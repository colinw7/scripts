#include <QWidget>
#include <QRandomGenerator>
#include <set>

class QPainter;
class QPushButton;

class CQUSCitizen : public QWidget {
  Q_OBJECT

 public:
  struct Answer {
    QString str;
  };

  using Answers = std::vector<Answer>;

  struct Question {
    QStringList strs;

    Answers answers;
  };

  using Questions = std::vector<Question>;

 public:
  CQUSCitizen();

  virtual ~CQUSCitizen();

  void init();

  bool isDebug() const { return debug_; }
  void setDebug(bool b) { debug_ = b; }

  QSize sizeHint() const override { return QSize(1200, 800); }

  void paintEvent(QPaintEvent *) override;

 private:
  bool loadFile();

  void nextQuestion();

 private slots:
  void answerSlot();
  void passSlot();
  void failSlot();

 private:
  using QuestionIds = std::set<int>;

  bool              debug_        { false };
  Questions         questions_;
  QuestionIds       questionIds_;
  int               questionId_   { -1 };
  bool              showAnswer_   { false };
  QRandomGenerator* rnd_          { nullptr };
  QPushButton*      answerButton_ { nullptr };
  QPushButton*      passButton_   { nullptr };
  QPushButton*      failButton_   { nullptr };
  QFont             questionFont_;
  QFont             answerFont_;
  int               numPassed_    { 0 };
  int               numFailed_    { 0 };
};
