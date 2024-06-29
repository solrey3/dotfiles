# Use the official Debian 12 (Bookworm) image as the base image
FROM debian:12

# Set environment variables to non-interactive to avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Copy the start.sh script into the container
COPY start.sh /root/start.sh

# Make sure start.sh is executable
RUN chmod +x /root/start.sh

# Run the start script
RUN apt-get update && \
    apt-get install -y sudo curl && \
    /root/start.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Expose any required ports (if applicable)
# EXPOSE 22

# Set the default command to bash
CMD ["bash"]

