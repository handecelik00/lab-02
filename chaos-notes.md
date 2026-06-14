1\. The secret still exists in the layer created by:

&#x20;  RUN echo "AZURE\_CLIENT\_SECRET=my-super-secret-abc123" > /tmp/dev.env



2\. Docker history shows that the file was deleted later, but deleting a file does not remove it from previous image layers.



3\. Docker layers are immutable. Secrets written during build remain in the image history even after deletion.



4\. If pushed to ACR, the secret could be exposed to anyone with access to the image. First action: revoke/rotate the credential and rebuild the image without embedding secrets.



1\. The secret still exists in the layer created by:

&#x20;  RUN echo "AZURE\_CLIENT\_SECRET=my-super-secret-abc123" > /tmp/dev.env



2\. Docker history shows both commands: the secret was created and later deleted. The deletion does not remove the secret from the previous layer.



3\. The correct way is to use Docker BuildKit secrets, for example --secret. Secrets should not be written into Dockerfile layers.



4\. If this image were pushed to ACR, the secret could be exposed. The first action would be to revoke/rotate the credential, delete the image, and rebuild it safely.

