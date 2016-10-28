int ftserve_check_user(char*user, char*pass)
{
	char username[MAXSIZE];
	char password[MAXSIZE];
	char *pch;
	char buf[MAXSIZE];
	char *line = NULL;
	size_t num_read;						
	size_t len = 0;
	FILE* fd;
	int auth = 0;

	fd = fopen(".auth", "r");
	if (fd == NULL) {
		perror("file not found");
		exit(1);
	}	
	while ((num_read = getline(&line, &len, fd)) != -1) {
		memset(buf, 0, MAXSIZE);
		strcpy(buf, line);

		pch = strtok (buf," ");
		strcpy(username, pch);
		if (pch != NULL) {
			pch = strtok (NULL, " ");
			strcpy(password, pch);
		}
		// remove end of line and whitespace
		trimstr(password, (int)strlen(password));

	
		if ((strcmp(user,username)==0) && (strcmp(pass,password)==0)) {
			auth = 1;
			break;
		}		
	}
	free(line);	
	fclose(fd);	
	return auth;
}
