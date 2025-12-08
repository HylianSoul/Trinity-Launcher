FROM archlinux:latest
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm base-devel git curl qt5-base qt5-tools qt5-declarative qtcreator cmake clang make gcc gnupg



WORKDIR /project
CMD ["/bin/bash"]
