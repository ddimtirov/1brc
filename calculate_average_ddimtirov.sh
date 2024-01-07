#!/bin/sh
#
#  Copyright 2023 The original authors
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

# --enable-preview to use the new memory mapped segments
# We don't allocate much, so just give it 1G heap and turn off GC; the AlwaysPreTouch was suggested by the ergonomics
JAVA_OPTS="--enable-preview -da -dsa -Xms1g -Xmx1g -XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC  -XX:+AlwaysPreTouch"
JAVA_OPTS="--enable-preview -da -dsa -Xms1g -Xmx1g"

if [ -d cr ]
then JAVA_OPTS="$JAVA_OPTS -XX:CRaCRestoreFrom=cr" # enable CRaC
else JAVA_OPTS="$JAVA_OPTS -XX:CRaCCheckpointTo=cr -Dcrac.checkpoint=true" # instruct to store a checkpoint if not present
fi

#sdk install java 21.0.1.crac-librca
#dnf -y install libbsd
#sdk use java 21.0.1.crac-librca

time java $JAVA_OPTS --class-path target/average-1.0.0-SNAPSHOT.jar dev.morling.onebrc.CalculateAverage_ddimtirov
