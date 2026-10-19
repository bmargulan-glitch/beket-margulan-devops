#!/usr/bin/env bash
# System information script for Margulan Beket

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
INFO_FILE="$PROJECT_DIR/Beket_Margulan_info.txt"

# Значения можно переопределить переменными окружения (например, из Jenkins)
NAME="${STUDENT_NAME:-Margulan}"
SURNAME="${STUDENT_SURNAME:-Beket}"
GROUP="${STUDENT_GROUP:-it2-2302}"
SID="${STUDENT_ID:-38109}"

line="=============================="

echo "$line"
echo "Student Information"
echo "$line"
echo
echo "Name: $NAME"
echo "Surname: $SURNAME"
echo "Group: $GROUP"
echo "Student ID: $SID"
echo
echo "$line"
echo "System Information"
echo "$line"
echo
echo "Username: $(whoami)"
echo "Hostname: $(hostname 2>/dev/null || cat /etc/hostname)"
echo "Current Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Operating System: $(uname -s -r -m)"
echo "Disk Usage: $(df -h / | awk 'NR==2 {print $3 " used of " $2 " (" $5 ")"}')"
if command -v free >/dev/null 2>&1; then
  echo "Memory Usage: $(free -h | awk '/^Mem:/ {print $3 " used of " $2}')"
else
  echo "Memory Usage: 'free' command is not available on this system"
fi
echo

if [ -f "$INFO_FILE" ]; then
  echo "Student information file exists."
else
  echo "Student information file does not exist."
fi
