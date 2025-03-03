#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include <string.h>

int validare_secventa(const char* secventa, const char* cuvant_principal);

int main() {
    char sir[200];
    char primulCuvant[100];

    int cnt_cuvinte = 0;
    int cnt = 0;

    printf("Introduceti un sir de caractere: ");
    fgets(sir, sizeof(sir), stdin);
    sir[strcspn(sir, "\n")] = '\0';  // Elimin newline-ul

    char* p = strtok(sir, " ");
    if (p != NULL) {
        strcpy(primulCuvant, p);
	cnt_cuvinte++;
    } else {
        printf("Nu s-a introdus niciun cuvant.\n");
        return 0;
    }

    p = strtok(NULL, " ");
    while (p != NULL) {

       	int rezultat = validare_secventa(primulCuvant, p);
        if (rezultat) {
           cnt++; 
        }

	cnt_cuvinte++;
        p = strtok(NULL, " ");
    }

    cnt++;
    if (cnt == cnt_cuvinte)
	printf("Toate sirurile de caractere au ca si subsecventa primul sir de caractere");
    else
        printf("Nu toate sirurile de caractere au ca si subsecventa primul sir de caractere");

    return 0;
}
