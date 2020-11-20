#!/bin/bash

SRC_DIR="${ami-project_SOURCE_DIR}"
BIN_DIR="${ami-project_BINARY_DIR}"
AMIDEBUG="${ami-project_BINARY_DIR}/bin/amidebug"

TMPFILE="${ami-project_BINARY_DIR}/$1.test.tmp"

if [ $# -lt 1 ]
then
    echo "$0 <amifile>"
    exit 1
fi

$AMIDEBUG $SRC_DIR/tests/$1 --simple > $TMPFILE
diff -u $TMPFILE $SRC_DIR/tests/$1.test >/dev/null
RETVAL=$?
if [ $RETVAL -eq 0 ]; then rm "$TMPFILE"; fi
exit $RETVAL


