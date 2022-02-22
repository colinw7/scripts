#include <iostream>
#include <cmath>

void drawClockFace(int hour, int minute);
void clearScreen();
void drawRect(int x1, int y1, int x2, int y2);
void drawLine(int x1, int y1, int x2, int y2, char c);
void printScreen();

int
main(int argc, char **argv)
{
  int hour   = 3;
  int minute = 0;

  if (argc > 1)
    hour = atoi(argv[1]);

  if (argc > 2)
    minute = atoi(argv[2]);

  drawClockFace(hour, minute);

  return 0;
}

static const int screen_size = 24;
static char      screen[screen_size][screen_size];

void
drawClockFace(int hour, int minute)
{
  clearScreen();

  if (hour < 1 || hour > 12) return;
  if (minute < 0 || minute >= 60) return;

  auto hourDeltaAngle   = 2*M_PI/12;
  auto minuteDeltaAngle = 2*M_PI/60;

  auto hourAngle   = M_PI/2 - (hour != 12 ? hour : 0)*hourDeltaAngle;
  auto minuteAngle = M_PI/2 - minute*minuteDeltaAngle;

  auto hourRadius   = 6;
  auto minuteRadius = 10;

  int xc = screen_size/2;
  int yc = screen_size/2;

  drawRect(0, 0, screen_size - 1, screen_size - 1);

  drawLine(xc, yc, xc + hourRadius*std::cos(hourAngle),
                   yc - hourRadius*std::sin(hourAngle), '*');
  drawLine(xc, xc, xc + minuteRadius*std::cos(minuteAngle),
                   yc - minuteRadius*std::sin(minuteAngle), '#');

  printScreen();
}

void
clearScreen()
{
  for (int x = 0; x < screen_size; ++x)
    for (int y = 0; y < screen_size; ++y)
      screen[x][y] = ' ';
}

void
drawLine(int x1, int y1, int x2, int y2, char c)
{
  int dx = x2 - x1;
  int dy = y2 - y1;

  if (std::abs(dx) > std::abs(dy)) {
    if (dx < 0)
      return drawLine(x2, y2, x1, y1, c);

    if (dx >= 0) {
      auto mapY = [&](int x) {
        return int(1.0*(x - x1)*(y2 - y1)/(x2 - x1) + y1);
      };

      for (int x = x1; x <= x2; ++x) {
        screen[x][mapY(x)] = c;
      }
    }
    else {
      for (int y = y1; y < y2; ++y)
        screen[x1][y] = c;
    }
  }
  else {
    if (dy < 0)
      return drawLine(x2, y2, x1, y1, c);

    if (dy >= 0) {
      auto mapX = [&](int y) {
        return int(1.0*(y - y1)*(x2 - x1)/(y2 - y1) + x1);
      };

      for (int y = y1; y <= y2; ++y) {
        screen[mapX(y)][y] = c;
      }
    }
    else {
      for (int x = x1; x < x2; ++x)
        screen[x][y1] = c;
    }
  }
}

void
drawRect(int x1, int y1, int x2, int y2)
{
  for (int y = y1; y < y2; ++y) {
    screen[x1][y] = '|';
    screen[x2][y] = '|';
  }

  for (int x = x1; x < x2; ++x) {
    screen[x][y1] = '-';
    screen[x][y2] = '-';
  }

  screen[x1][y1] = '+';
  screen[x2][y1] = '+';
  screen[x1][y2] = '+';
  screen[x2][y2] = '+';
}

void
printScreen()
{
  for (int y = 0; y < screen_size; ++y) {
    for (int x = 0; x < screen_size; ++x)
      std::cout << screen[x][y];

    std::cout << "\n";
  }
}
