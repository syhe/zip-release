#! /bin/sh

# Create archive or exit if command fails
set -eu

ERRORMSG="\n⛔ Unable to create %s archive.\n"

filename="${1}"
path="${2}"
directory="${3}"
exclusions="${4}"
archive_type="${5}"

printf "\n📦 Creating %s archive...\n" "$archive_type"

if [ "$directory" != "." ]; then
  cd "$directory"
fi

if [ "$archive_type" = "zip" ]; then
  if [ -z "$exclusions" ]; then
    zip -r "$filename" "$path" || {
      printf "$ERRORMSG" "$archive_type"
      exit 1
    }
  else
    zip -r "$filename" "$path" -x "$exclusions" || {
      printf "$ERRORMSG" "$archive_type"
      exit 1
    }
  fi
elif [ "$archive_type" = "tar" ]; then
  if [ -z "$exclusions" ]; then
    tar -zcvf "$filename" "$path" || {
      printf "$ERRORMSG" "$archive_type"
      exit 1
    }
  else
    tar -zcvf "$filename" "$path" --exclude="$exclusions" || {
      printf "$ERRORMSG" "$archive_type"
      exit 1
    }
  fi
else
  printf "\n⛔ Unsupported archiving tool.\n"
  exit 1
fi

printf "\n✔ Successfully created %s archive.\n" "$archive_type"
