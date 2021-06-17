SOURCE_DIR=source

APK_SOURCE=mirrors.cloud.tencent.com
PIP_SOURCE=mirrors.cloud.tencent.com

all: soruce
	docker build -t sphinx-doc . --build-arg BUILD_ENV=local

.PHONY: clean soruce

clean:
	rm -rf ${SOURCE_DIR}

soruce: source_dir apk_source pip_source

.ONESHELL:
source_dir:
	mkdir -p ${SOURCE_DIR}

apk_source:
	mkdir -p ${SOURCE_DIR}/apk/
	cat  <<- EOF > ./source/apk/repositories
		https://${APK_SOURCE}/alpine/v3.13/main
		https://${APK_SOURCE}/alpine/v3.13/community
	EOF

pip_source:
	cat  <<- EOF > ${SOURCE_DIR}/pip.conf
		[global]
		index-url = https://${PIP_SOURCE}/pypi/simple
		trusted-host = ${PIP_SOURCE}
		timeout = 120
	EOF
