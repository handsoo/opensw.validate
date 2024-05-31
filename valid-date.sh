#!/bin/bash

# 입력 인수가 3개가 아닐 경우 종료
if [ "$#" -ne 3 ]; then
  echo "입력값 오류"
  exit 1
fi

# 첫 번째 인수: 월
# 두 번째 인수: 일
# 세 번째 인수: 연도
month=$1
day=$2
year=$3

# 달 이름을 표준화하는 함수
function standardize_month() {
  local month_input=$1
  case "${month_input,,}" in
    jan | january | 1) echo "Jan" ;;
    feb | february | 2) echo "Feb" ;;
    mar | march | 3) echo "Mar" ;;
    apr | april | 4) echo "Apr" ;;
    may | 5) echo "May" ;;
    jun | june | 6) echo "Jun" ;;
    jul | july | 7) echo "Jul" ;;
    aug | august | 8) echo "Aug" ;;
    sep | september | 9) echo "Sep" ;;
    oct | october | 10) echo "Oct" ;;
    nov | november | 11) echo "Nov" ;;
    dec | december | 12) echo "Dec" ;;
    *) echo "Invalid month" ;;
  esac
}

# 윤년 판별 함수
function is_leap_year() {
  local year_input=$1
  if (( year_input % 4 != 0 )); then
    echo 0
  elif (( year_input % 400 == 0 )); then
    echo 1
  elif (( year_input % 100 == 0 )); then
    echo 0
  else
    echo 1
  fi
}

# 각 달의 일수 설정 함수
function days_in_month() {
  local month_input=$1
  local year_input=$2
  case "$month_input" in
    Jan) echo 31 ;;
    Feb)
      if [ "$(is_leap_year "$year_input")" -eq 1 ]; then
        echo 29
      else
        echo 28
      fi
      ;;
    Mar) echo 31 ;;
    Apr) echo 30 ;;
    May) echo 31 ;;
    Jun) echo 30 ;;
    Jul) echo 31 ;;
    Aug) echo 31 ;;
    Sep) echo 30 ;;
    Oct) echo 31 ;;
    Nov) echo 30 ;;
    Dec) echo 31 ;;
    *) echo 0 ;;
  esac
}

# 월 표준화
standardized_month=$(standardize_month "$month")
if [ "$standardized_month" == "Invalid month" ]; then
  echo "잘못된 월 입력: $month"
  exit 1
fi

# 일수 판별
days_in_this_month=$(days_in_month "$standardized_month" "$year")
if (( day < 1 || day > days_in_this_month )); then
  echo "$standardized_month $year는 $days_in_this_month일까지만 유효합니다. 입력 날짜: $day는 유효하지 않습니다"
  exit 1
fi

# 최종 출력
echo "$standardized_month $day $year"
