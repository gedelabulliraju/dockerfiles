ARG version
FROM almalinux:${version:-9}
ARG course="DevOps with AWS" \
    duration="120hrs"
ENV duration=$duration
RUN echo "Course: $course, duration: $duration, version: $version"
CMD ["sleep","100"]