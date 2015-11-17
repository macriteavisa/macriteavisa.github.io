clean=

cat postdata.org | while read l; do
        id=`echo $l | cut -d'|' -f2 | cut -d'/' -f4 | sed s/' '/''/g`
        va=`echo $id | cut -d'?' -f2`
        id=`echo $id | cut -d'?' -f1`
        t=`echo $l | cut -d'|' -f3 | sed s/' *$'/''/g | sed s/'^ *'/''/g`
        s=`echo $l | cut -d'|' -f4 | sed s/' *$'/''/g | sed s/'^ *'/''/g`

        tt=`echo $t | sed s/' '/'-'/g`
        dt=`date --iso-8601`
        f="_posts/$dt-$tt.markdown"
        echo $id -- $t -- $s -- $tt

        cat<<EOF> $f
---
title: "$t"
author: "$USER"
avatar: "img/authors/$USER.png"
video_id: "$id"
date: `date --rfc-3339=seconds`
EOF
        test -z $s  || echo "subtitle: \"$s\"" >> $f
        test -z $va || echo "video_args: \"$va\"" >> $f
        cat<<EOF>> $f
---
EOF
done


