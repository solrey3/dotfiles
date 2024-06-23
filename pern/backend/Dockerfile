# Use the official Node.js image.
FROM node:18

# Set the working directory
WORKDIR /app

# Copy the package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy the application code
COPY . .

# Expose the application port
EXPOSE 5000

# Start the application
CMD ["node", "server.js"]
