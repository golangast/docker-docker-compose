FROM golang:latest

# Set the Current Working Directory inside the container
WORKDIR /d

# Build Args
ARG LOG_DIR=/app/logs

# Create Log Directory
RUN mkdir -p ${LOG_DIR}

# Environment Variables
ENV LOG_FILE_LOCATION=${LOG_DIR}/app.log 

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY . .

# Build the Go app
RUN go build -o mains .

# Declare volumes to mount
VOLUME [${LOG_DIR}]

# Command to run the executable
CMD ["./mains"]
