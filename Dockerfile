FROM ubuntu:22.10
RUN apt update && apt upgrade -y && apt install -y tzdata wget
ENV TZ Asia/Tokyo
WORKDIR /opt
RUN apt install -y openjdk-17-jre && \
  wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastStableBuild/artifact/target/BuildTools.jar && \
  apt-get install -y git && \
  apt install -y screen
WORKDIR /root
RUN java -Xmx1024M -Xms1024M -jar /opt/BuildTools.jar --rev 1.19.3
RUN echo eula=true > eula.txt && echo "mv /mnt/var/* /root" > firstBoot.sh && \
    # echo "cp /mnt/var/plugins/* /mnt/var/minecraft/plugins" > firstBoot.sh && \
    echo "java -Xmx1024M -Xms1024M -jar spigot-1.19.3.jar" >> firstBoot.sh && \
    echo "mv /root/* /mnt/var" >> firstBoot.sh && chmod 777 firstBoot.sh && mkdir /mnt/var
RUN echo "java -Xmx1024M -Xms1024M -jar spigot-1.19.3.jar" >> boot.sh && chmod 777 boot.sh
# CMD ["sh", "firstBoot.sh"]