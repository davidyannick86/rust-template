# Build stage
FROM rust:latest as builder

WORKDIR /app

# Copy the source code
COPY . .

# Build the application
RUN cargo build --release

# Run stage
FROM gcr.io/distroless/cc-debian12

WORKDIR /app

# Copy the built binary from the build stage
COPY --from=builder /app/target/release/{{project-name}} .

# Command to run the application
CMD ["./{{project-name}}"]