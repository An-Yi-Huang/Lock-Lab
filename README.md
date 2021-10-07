# Introduction
This is a very simple social media system for users to leave messages on their friends’ walls. The system is built by bash scripts on GNU/Linux 200-Ubuntu, and tested on the same environment.

<img src="https://user-images.githubusercontent.com/71880332/136440809-0355d709-fa83-4fa8-b064-848c62ac1496.JPG" alt="Capture" width="600"/>



# Server
- A server will have only one named pipe for clients to put request messages into, and for server.sh to retrieve request messages from.
- There is an infinite while-loop in server.sh to keep the server on, and waiting for any client’s request. The infinite while-loop will keep detecting the server.pipe. Once it finds a new request in the pipe, it will take out the request data, and use switch-case to classify the requests. After classifying the request it will call the corresponding function for them to deal with the jobs. Since this pipe is only for the server to provide service for clients, it will be removed when the server has shut down.
-	For dealing with many clients’ requests at the same time, after classifying requests, the server will call the corresponding functions (e.g., create.sh, add.sh, post.sh, show.sh), and make them run in the background.
-	The concurrency problems will happen when different background processes are retrieving and editing the same file. The files that will be accessed are the users’ files (friends and wall). So, I select the code snippets that There could be different jobs, e.g., add.sh, running in the background at the same time, trying to access the same user’s data. So, there will be a data inconsistency problem. To solve this problem, I use P.sh and V.sh to implement the semaphore concept. The following is one scenario that I find out having the critical section, and I use P.sh and V.sh to protect users’ data.

<img src="https://user-images.githubusercontent.com/71880332/136441375-986b795e-dd6d-4fd9-8ef8-4102c6f0b151.JPG" alt="Capture" width="600"/>

- This is in add.sh. The critical section of this script is: 1. checking if a user’s name is on the specific friend list. 2. adding the user’s name on the list, if it is not on the list. As a result, before the checking, the process should get the lock first. At the end, no matter if we add the user on the friend list or not, we have to release the lock.
-	Responding messages to clients:
After a background process finishes its job, it will echo a message to the standard output. Then, the server.sh will redirect the output to clients’ named pipe, so that the corresponding client can retrieve the result of its requests.


#	Client
-	There could be multiple clients requesting service from the server at the same time. For not making server mix up data from different clients, every client has its own id, and its own named pipe.
- A pipe will be set up for a client, when every client.sh instance is created and initialized. The pipe will keep waiting for the response from the server, until there are no more responses to receive. Once the client receives all the messages, the named pipe will be deleted.
