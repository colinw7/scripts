#include <CQUSCitizen.h>
#include <CXMLLib.h>
#include <CQApp.h>

#include <QPainter>
#include <QPushButton>

int
main(int argc, char **argv)
{
  CQApp app(argc, argv);

  bool debug = false;

  std::vector<std::string> args;

  for (int i = 1; i < argc; ++i) {
    if (argv[i][0] == '-') {
      if (strcmp(&argv[i][1], "debug") == 0)
        debug = true;
      else
        std::cerr << "Invalid option '" << argv[i] << "'\n";
    }
    else
      args.push_back(argv[i]);
  }

  auto *test = new CQUSCitizen;

  test->setDebug(debug);

  test->init();

  test->show();

  return app.exec();
}

//----------------

CQUSCitizen::
CQUSCitizen()
{
}

void
CQUSCitizen::
init()
{
  questionFont_ = this->font();
  questionFont_.setPointSize(24);
  questionFont_.setBold(true);

  answerFont_ = this->font();
  answerFont_.setPointSize(20);

  //---

  if (! loadFile())
    return;

  //---

  int n = int(questions_.size());

  for (int i = 0; i < n; ++i)
    questionIds_.insert(i);

  rnd_ = QRandomGenerator::global();
  //rnd_.seed(time_t(nullptr));

  int nr = rnd_->bounded(0, int(questionIds_.size()));

  questionId_ = *std::next(questionIds_.begin(), nr);

  //---

  answerButton_ = new QPushButton("Show Answer", this);
  passButton_   = new QPushButton("Pass", this);
  failButton_   = new QPushButton("Fail", this);

  connect(answerButton_, SIGNAL(pressed()), this, SLOT(answerSlot()));
  connect(passButton_, SIGNAL(pressed()), this, SLOT(passSlot()));
  connect(failButton_, SIGNAL(pressed()), this, SLOT(failSlot()));

  //---

  updateState();
}

CQUSCitizen::
~CQUSCitizen()
{
}

bool
CQUSCitizen::
loadFile()
{
  CXML     xml;
  CXMLTag *tag;

  xml.setDebug(debug_);
  xml.addPreserveSpaceTag("question");

  try {
    if (! xml.read("us_citizen.xml", &tag))
      return false;
  }
  catch (...) {
    return false;
  }

  if (tag->getName() != "us_citizen")
    return false;

  const auto &options     = tag->getOptions();
  auto        num_options = tag->getNumOptions();

  for (size_t j = 0; j < num_options; ++j) {
    auto *option = options[j];

    const auto &opt_name  = option->getName ();
  //const auto &opt_value = option->getValue();

    std::cerr << "Unrecognised us_citizen option '" << opt_name << "'\n";
  }

  auto children     = tag->getChildren();
  auto num_children = tag->getNumChildren();

  for (size_t i = 0; i < num_children; ++i) {
    const auto *token = children[i];
    if (! token->isTag()) continue;

    auto       *tag1  = token->getTag();
    const auto &name1 = tag1->getName();

    if      (name1 == "question") {
      Question question;

      auto        num_options1 = tag1->getNumOptions();
      const auto &options1     = tag1->getOptions();

      for (size_t j1 = 0; j1 < num_options1; ++j1) {
        auto *option1 = options1[j1];

        const auto &opt_name1  = option1->getName ();
      //const auto &opt_value1 = option1->getValue();

        if (opt_name1 == "id") {
        }
        else
          std::cerr << "Unrecognised question option '" << opt_name1 << "'" << "\n";
      }

      auto children1     = tag1->getChildren();
      auto num_children1 = tag1->getNumChildren();

      for (size_t i1 = 0; i1 < num_children1; ++i1) {
        const auto *token1 = children1[i1];

        if      (token1->isTag()) {
          auto       *tag2  = token1->getTag();
          const auto &name2 = tag2->getName();

          if      (name2 == "answer") {
            Answer answer;

            auto        num_options2 = tag2->getNumOptions();
            const auto &options2     = tag2->getOptions();

            for (size_t j2 = 0; j2 < num_options2; ++j2) {
              auto *option2 = options2[j2];

              const auto &opt_name2  = option2->getName ();
            //const auto &opt_value2 = option2->getValue();

              std::cerr << "Unrecognised answer option '" << opt_name2 << "'\n";
            }

            auto children2     = tag2->getChildren();
            auto num_children2 = tag2->getNumChildren();

            for (size_t i2 = 0; i2 < num_children2; ++i2) {
              const auto *token2 = children2[i2];

              if (token2->isText()) {
                const auto *text2 = token2->getText();

                auto str = QString::fromStdString(text2->getText()).trimmed();

                if (str != "")
                  answer.str = str;

                //std::cerr << "answer: " << text2->getText() << "\n";
              }
            }

            question.answers.push_back(answer);
          }
          else
            std::cerr << "Unrecognised tag '" << name2 << "'\n";
        }
        else if (token1->isText()) {
          const auto *text1 = token1->getText();

          auto str = QString::fromStdString(text1->getText()).trimmed();

          auto strs = str.split("\n");

          for (const auto &str : strs)
            if (str != "")
              question.strs << str;

          //std::cerr << "question: " << text1->getText() << "\n";
        }
      }

      questions_.push_back(question);
    }
    else
      std::cerr << "Unrecognised tag '" << name1 << "'\n";
  }

  if (debug_) {
    for (const auto &question : questions_) {
      for (const auto &str : question.strs)
        std::cerr << str.toStdString() << "\n";

      for (const auto &answer : question.answers) {
        std::cerr << " . " << answer.str.toStdString() << "\n";
      }
    }
  }

  return true;
}

void
CQUSCitizen::
paintEvent(QPaintEvent *)
{
  QPainter painter(this);

  if (questions_.empty())
    return;

  if (numPassed_ < 100) {
    const auto &question = questions_[size_t(questionId_)];

    painter.setFont(questionFont_);

    QFontMetrics fm(questionFont_);

    int th = fm.height();

    int ty = 2*th;

    //int maxTw = 0;

    //for (const auto &str : question.strs)
    //  maxTw = std::max(maxTw, fm.horizontalAdvance(str));

    for (const auto &str : question.strs) {
      int tw = fm.horizontalAdvance(str);

      int tx = (width() - tw)/2;

      painter.drawText(tx, ty, str);

      ty += th;
    }

    //---

    if (showAnswer_) {
      painter.setFont(answerFont_);

      QFontMetrics fm1(answerFont_);

      int ty1 = ty + 2*th;

      int th1 = fm1.height();

      int maxTw1 = 0;

      for (const auto &answer : question.answers)
        maxTw1 = std::max(maxTw1, fm1.horizontalAdvance(". " + answer.str));

      for (const auto &answer : question.answers) {
        int tx1 = (width() - maxTw1)/2;

        painter.drawText(tx1, ty1, ". " + answer.str);

        ty1 += th1;
      }
    }
  }
  else {
    auto doneText = "Finished";

    int px = width ()/2;
    int py = height()/2;

    QFontMetrics fm1(answerFont_);

    int tw = fm1.horizontalAdvance(doneText);

    painter.drawText(px - tw/2, py, doneText);
  }

  //---

  painter.setFont(font());

  QFontMetrics fm(painter.font());

  int th = fm.height();

  int tx1 = 0;
  int ty1 = height() - th;

  painter.drawText(tx1, ty1, QString("Passed %1, Failed %2 (Questions %3/%4)").
    arg(numPassed_).arg(numFailed_).arg(questionIds_.size()).arg(questions_.size()));

  //---

  failButton_->move(width() - failButton_->width() - 8, height() - failButton_->height() - 8);

  passButton_->move(failButton_->x() - passButton_->width() - 8, failButton_->y());
  answerButton_->move(passButton_->x() - answerButton_->width() - 16, failButton_->y());
}

void
CQUSCitizen::
passSlot()
{
  ++numPassed_;

  questionIds_.erase(questionId_);

  if (! questionIds_.empty())
    nextQuestion();
  else
    updateState();
}

void
CQUSCitizen::
failSlot()
{
  ++numFailed_;

  nextQuestion();
}

void
CQUSCitizen::
nextQuestion()
{
  int nr;

  if (questionIds_.size() > 1)
    nr = rnd_->bounded(0, int(questionIds_.size()));
  else
    nr = *questionIds_.begin();

  questionId_ = *std::next(questionIds_.begin(), nr);

  showAnswer_ = false;

  updateState();
}

void
CQUSCitizen::
answerSlot()
{
  showAnswer_ = true;

  updateState();
}

void
CQUSCitizen::
updateState()
{
  answerButton_->setEnabled(! showAnswer_);
  passButton_  ->setEnabled(showAnswer_);
  failButton_  ->setEnabled(showAnswer_);

  update();
}
