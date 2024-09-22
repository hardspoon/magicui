# Step 1: Define the base image. Use Node.js LTS version as the base image.
FROM node:18-alpine

# Step 2: Set the working directory inside the container.
WORKDIR /app

# Step 3: Copy 'package.json' and install dependencies.
COPY package.json .
COPY package-lock.json .
RUN npm install

# Step 4: Copy Prisma files to take care of migrations
COPY prisma ./prisma
RUN npx prisma generate

# Step 5: Copy the rest of the application code to the container.
COPY . .

# Step 6: Build the Next.js application.
RUN npm run build

# Step 7: Expose the port the app runs on (in case of Next.js, default is 3000)
EXPOSE 3000

# Step 8: Define the command to run the app
CMD ["npm", "run", "start"]
