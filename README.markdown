# Steps to reproduce

1. Open the project
2. Configure codesigning
3. Run the main app once
4. Run the sharing extension, and choose `realmcrash` as the launched application
5. Tap "Run test". Contents should  be produced in the console telling you that the test has started and transactions are being committed.
6. The sharing sheet will be shown, tap `realmcrash share`
7. Tap "Run test" in the sharing extension.

After a short time the sharing extension crashes hits an exception with `abort() called`: 
   
`libc++abi: terminating with uncaught exception of type 
realm::util::DecryptionFailed: Decryption failed: 'unable to decrypt after 0 seconds (retry_count=0, from=i != bytes_read, size=16384)'`


