# Chaos Task Answers

1. The secret still exists in the layer created by:

RUN echo "AZURE_CLIENT_SECRET=my-super-secret-abc123" > /tmp/dev.env

Even though the file was deleted later, the original layer still contains the secret.

2. What does docker history tell you about the RUN rm command?

Docker history shows that the file was deleted in a later layer. However, deleting a file does not remove it from previous layers because Docker layers are immutable. The secret remains accessible in the image history.

3. What is the correct way to handle build-time secrets?

The correct approach is to use Docker BuildKit secrets (--secret) or a secrets manager. Secrets should never be written into Dockerfile layers because they become part of the image history.

4. What would happen if this image were pushed to ACR?

Anyone with access to the image could potentially recover the secret from the image layers. The first action would be to revoke or rotate the exposed credential, remove the vulnerable image, and rebuild the image using secure secret handling methods.
