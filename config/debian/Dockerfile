# Use the official Debian 12 (Bookworm) image as the base image
FROM debian:12

# Set environment variables to non-interactive to avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Copy the setup.sh script into the container
COPY setup.sh /root/setup.sh

# Make sure setup.sh is executable
RUN chmod +x /root/setup.sh

# Run the setup script
RUN apt-get update && \
    apt-get install -y sudo curl && \
    /root/setup.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Expose any required ports (if applicable)
# EXPOSE 22

# Set the default command to bash
CMD ["bash"]

