FROM archlinux:latest

WORKDIR /data

RUN pacman -Sy --noconfirm sagemath
RUN pacman -Sy --noconfirm python3
RUN pacman -Sy --noconfirm pandoc texlive-core
RUN python -m ensurepip
RUN pip3 install jupyterlab; mkdir -p $HOME/.local/share/jupyter
COPY JupyterLab-config.py /root/.jupyter/jupyter_server_config.py
RUN ln -s $(sage -sh -c 'ls -d $SAGE_VENV/share/jupyter/kernels/sagemath') $HOME/.local/share/jupyter/sagemath-dev

VOLUME /data

EXPOSE 80/tcp

ENTRYPOINT jupyter-lab
