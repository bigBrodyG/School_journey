#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define FILE_PATH "questionario.txt"
#define MAX_LINE 1024
#define PREVIEW_LEN 50

typedef struct {
    char ques[MAX_LINE];
    char answers[4][MAX_LINE];
    char correct; // 'A'..'D'
} Question;

/* Utility */
static void trim_newline(char *s) {
    if (!s) return;
    size_t len = strlen(s);
    while (len && (s[len-1] == '\n' || s[len-1] == '\r')) {
        s[--len] = '\0';
    }
}

static int is_blank_or_ws(const char *s) {
    if (!s) return 1;
    while (*s) {
        if (!isspace((unsigned char)*s)) return 0;
        s++;
    }
    return 1;
}

static void read_line_prompt(const char *prompt, char *buf, size_t sz) {
    for (;;) {
        if (prompt) {
            printf("%s", prompt);
            fflush(stdout);
        }
        if (!fgets(buf, (int)sz, stdin)) {
            clearerr(stdin);
            buf[0] = '\0';
        }
        trim_newline(buf);
        if (!is_blank_or_ws(buf)) return;
        printf("Input vuoto. Riprova.\n");
    }
}

static char read_choice_abcd(const char *prompt) {
    char line[64];
    for (;;) {
        printf("%s", prompt);
        fflush(stdout);
        if (!fgets(line, sizeof(line), stdin)) {
            clearerr(stdin);
            continue;
        }
        trim_newline(line);
        if (line[0] == '\0') continue;
        char c = (char)toupper((unsigned char)line[0]);
        if (c >= 'A' && c <= 'D') return c;
        printf("Scelta non valida. Inserisci A, B, C o D.\n");
    }
}

static int read_int_in_range(const char *prompt, int min, int max, int *out) {
    char line[128];
    for (;;) {
        if (prompt) {
            printf("%s", prompt);
            fflush(stdout);
        }
        if (!fgets(line, sizeof(line), stdin)) {
            clearerr(stdin);
            continue;
        }
        char *end = NULL;
        long v = strtol(line, &end, 10);
        if (end == line) {
            printf("Per favore inserisci un numero.\n");
            continue;
        }
        if (v < min || v > max) {
            printf("Valore fuori intervallo (%d-%d).\n", min, max);
            continue;
        }
        *out = (int)v;
        return 1;
    }
}

/* File parsing */
static int write_question(FILE *f, const Question *q) {
    if (fprintf(f, "%s\n", q->ques) < 0) return 0;
    for (int i = 0; i < 4; ++i) {
        if (fprintf(f, "%s\n", q->answers[i]) < 0) return 0;
    }
    if (fprintf(f, "%c\n\n", q->correct) < 0) return 0;
    return 1;
}

static int read_next_nonblank_line(FILE *f, char *buf, size_t sz) {
    while (fgets(buf, (int)sz, f)) {
        trim_newline(buf);
        if (!is_blank_or_ws(buf)) return 1;
    }
    return 0; // EOF
}

static int read_next_question(FILE *f, Question *q) {
    char line[MAX_LINE];

    if (!read_next_nonblank_line(f, q->ques, sizeof(q->ques))) return 0; // no more questions

    for (int i = 0; i < 4; ++i) {
        if (!read_next_nonblank_line(f, q->answers[i], sizeof(q->answers[i]))) {
            return 0; // malformed
        }
    }
    if (!read_next_nonblank_line(f, line, sizeof(line))) return 0; // malformed
    q->correct = (char)toupper((unsigned char)line[0]);
    if (q->correct < 'A' || q->correct > 'D') {
        // malformed; try to continue by treating as invalid
        return 0;
    }
    return 1;
}

/* Features */
static void aggiungi_domanda(void) {
    FILE *f = fopen(FILE_PATH, "a");
    if (!f) {
        perror("Impossibile aprire il file per appensione");
        return;
    }

    Question q;
    memset(&q, 0, sizeof(q));

    read_line_prompt("Inserisci il Quesito: ", q.ques, sizeof(q.ques));
    read_line_prompt("Risposta A: ", q.answers[0], sizeof(q.answers[0]));
    read_line_prompt("Risposta B: ", q.answers[1], sizeof(q.answers[1]));
    read_line_prompt("Risposta C: ", q.answers[2], sizeof(q.answers[2]));
    read_line_prompt("Risposta D: ", q.answers[3], sizeof(q.answers[3]));
    q.correct = read_choice_abcd("Opzione corretta (A, B, C o D): ");

    if (!write_question(f, &q)) {
        perror("Errore in scrittura sul file");
    } else {
        printf("Domanda aggiunta con successo.\n");
    }

    fclose(f);
}

static void somministra_questionario(void) {
    FILE *f = fopen(FILE_PATH, "r");
    if (!f) {
        printf("Nessun file di questionario trovato (%s).\n", FILE_PATH);
        return;
    }

    int tot = 0, ok = 0;
    Question q;

    while (read_next_question(f, &q)) {
        ++tot;
        printf("\nDomanda %d:\n", tot);
        printf("%s\n", q.ques);
        printf("A) %s\n", q.answers[0]);
        printf("B) %s\n", q.answers[1]);
        printf("C) %s\n", q.answers[2]);
        printf("D) %s\n", q.answers[3]);
        char ans = read_choice_abcd("La tua risposta (A, B, C o D): ");
        if (ans == q.correct) {
            printf("Corretto!\n");
            ++ok;
        } else {
            printf("Errato. Risposta corretta: %c\n", q.correct);
        }
    }

    fclose(f);

    if (tot == 0) {
        printf("Il questionario è vuoto.\n");
    } else {
        printf("\nHai totalizzato %d su %d risposte corrette.\n", ok, tot);
    }
}

static void cancella_domanda(void) {
    FILE *f = fopen(FILE_PATH, "r");
    if (!f) {
        printf("Nessun file di questionario trovato (%s).\n", FILE_PATH);
        return;
    }

    // Carica tutte le domande
    size_t cap = 16, n = 0;
    Question *arr = (Question *)malloc(cap * sizeof(Question));
    if (!arr) {
        fclose(f);
        printf("Memoria insufficiente.\n");
        return;
    }

    Question q;
    while (read_next_question(f, &q)) {
        if (n == cap) {
            cap *= 2;
            Question *tmp = (Question *)realloc(arr, cap * sizeof(Question));
            if (!tmp) {
                free(arr);
                fclose(f);
                printf("Memoria insufficiente.\n");
                return;
            }
            arr = tmp;
        }
        arr[n++] = q;
    }
    fclose(f);

    if (n == 0) {
        free(arr);
        printf("Il questionario è vuoto, nulla da cancellare.\n");
        return;
    }

    // Stampa anteprime
    printf("\nElenco domande:\n");
    for (size_t i = 0; i < n; ++i) {
        char preview[PREVIEW_LEN + 4]; // + "..."
        size_t len = strlen(arr[i].ques);
        if (len > PREVIEW_LEN) {
            memcpy(preview, arr[i].ques, PREVIEW_LEN);
            preview[PREVIEW_LEN] = '\0';
            // taglia su bordo pulito (opzionale), poi aggiungi "..."
            printf("%zu) %s...\n", i + 1, preview);
        } else {
            printf("%zu) %s\n", i + 1, arr[i].ques);
        }
    }

    // Chiedi quale eliminare
    int idx = 0;
    if (!read_int_in_range("Inserisci il numero della domanda da eliminare: ", 1, (int)n, &idx)) {
        free(arr);
        return;
    }
    size_t del = (size_t)(idx - 1);

    // Scrivi di nuovo il file senza la domanda scelta
    f = fopen(FILE_PATH, "w");
    if (!f) {
        perror("Impossibile aprire il file in scrittura");
        free(arr);
        return;
    }

    for (size_t i = 0; i < n; ++i) {
        if (i == del) continue;
        if (!write_question(f, &arr[i])) {
            perror("Errore in scrittura sul file");
            fclose(f);
            free(arr);
            return;
        }
    }
    fclose(f);
    free(arr);

    printf("Domanda %zu eliminata.\n", del + 1);
}

static void stampa_menu(void) {
    printf("\n=== Questionario a Crocette ===\n");
    printf("1) Aggiungi Domanda\n");
    printf("2) Somministra questionario\n");
    printf("3) Cancella Domanda\n");
    printf("0) Esci\n");
}

int main(void) {
    for (;;) {
        stampa_menu();
        int scelta = -1;
        if (!read_int_in_range("Scegli un'opzione: ", 0, 3, &scelta)) continue;

        switch (scelta) {
            case 1: aggiungi_domanda(); break;
            case 2: somministra_questionario(); break;
            case 3: cancella_domanda(); break;
            case 0: printf("Uscita.\n"); return 0;
            default: printf("Scelta non valida.\n"); break;
        }
    }
    return 0;
}