# Sphinx Dokcer 镜像

Sphinx Dokcer 镜像，用于个人书写文档，支持实时构建功能，包含以下组件：

* Sphinx 4.0.2
* sphinx-autobuild
* sphinx-rtd-theme

参考内容：

* 镜像构建与使用：https://github.com/sphinx-doc/docker
* 文档实时构建与预览：https://github.com/executablebooks/sphinx-autobuild


## 镜像

* [serial115200/sphinx-doc](https://hub.docker.com/repository/docker/serial115200/sphinx-doc)


## 使用
 
docker 默认使用 root 用户执行命令，创建属于 root 的文件，从而引发权限问题，即使镜像创建了新用户，也无法解决该问题，因此指定了用户与用户组，或许有更好的解决方案。

* 创建 Sphinx 项目:

```bash
docker run -it --rm --user "$(id -u):$(id -g)" -v $(pwd):/docs serial115200/sphinx-doc sphinx-quickstart
```
* 构建 html 文档:

```bash
docker run --rm --user "$(id -u):$(id -g)" -v $(pwd):/docs serial115200/sphinx-doc make html
```

* 实时构建 html 文档:

首先修改 sphinx-quickstart 创建的 Makefile 文件，在最后添加以下内容：

```make
livehtml:
    sphinx-autobuild "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O) --host 0.0.0.0
```

```bash
docker run -d --rm  --user "$(id -u):$(id -g)" -p 127.0.0.1:9000:8000 -v $(pwd):/docs sphinx-doc
```

网络映射限定为 127.0.0.1，避免暴露端口。
    