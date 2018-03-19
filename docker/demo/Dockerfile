# Use python:3.6 as our base image
FROM python:3.6

# Copy `hello.py` (on host) to
# `/app/hello.py` (on container)
COPY hello.py /app/hello.py

# Invoke `hello.py` when launching container
ENTRYPOINT /usr/bin/python /app/hello.py
