DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = ./hack/hadoop.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)

up:
	BASE_VERSION=$(current_branch) docker-compose up -d

down:
	BASE_VERSION=$(current_branch) docker-compose down

clean: down
	BASE_VERSION=$(current_branch) docker-compose down -v
	docker system prune -f
	rm -r hack/hadoop_datanode
	rm -r hack/hadoop_historyserver
	rm -r hack/hadoop_namenode
	rm -r hack/input

build:
	docker build -t closetool/hadoop-base:$(current_branch) ./base
	docker build -t closetool/hadoop-namenode:$(current_branch) --build-arg BASE_VERSION=$(current_branch) ./namenode
	docker build -t closetool/hadoop-datanode:$(current_branch) --build-arg BASE_VERSION=$(current_branch) ./datanode
	docker build -t closetool/hadoop-resourcemanager:$(current_branch) --build-arg BASE_VERSION=$(current_branch) ./resourcemanager
	docker build -t closetool/hadoop-nodemanager:$(current_branch) --build-arg BASE_VERSION=$(current_branch) ./nodemanager
	docker build -t closetool/hadoop-historyserver:$(current_branch) --build-arg BASE_VERSION=$(current_branch) ./historyserver
	docker build -t closetool/hadoop-submit:$(current_branch) --build-arg BASE_VERSION=$(current_branch) ./submit

push:
	docker push closetool/hadoop-base:$(current_branch)
	docker push closetool/hadoop-namenode:$(current_branch)
	docker push closetool/hadoop-datanode:$(current_branch)
	docker push closetool/hadoop-resourcemanager:$(current_branch)
	docker push closetool/hadoop-nodemanager:$(current_branch)
	docker push closetool/hadoop-historyserver:$(current_branch)
	docker push closetool/hadoop-submit:$(current_branch)

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} closetool/hadoop-base:$(current_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} closetool/hadoop-base:$(current_branch) hdfs dfs -copyFromLocal -f /opt/hadoop-3.3.6/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} closetool/hadoop-base:$(current_branch) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} closetool/hadoop-base:$(current_branch) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} closetool/hadoop-base:$(current_branch) hdfs dfs -rm -r /input
