#include <stdio.h>

int main() {
    int r, c;

    // Input the row and column size
    printf("Enter the number of rows: ");
    scanf("%d", &r);
    printf("Enter the number of columns: ");
    scanf("%d", &c);

    if (r <= 0 || c <= 0) {
        printf("Invalid row or column size. Please enter positive integers.\n");
        return 1; // Exit with an error code
    }

    int size = r * c;
    int matrix[size];

    // Input matrix elements into a 1D array
    printf("Enter the elements of the matrix (%d x %d):\n", r, c);
    for (int i = 0; i < size; i++) {
        printf("Element at index %d: ", i);
        scanf("%d", &matrix[i]);
    }

    // Print the original matrix
    printf("Original Matrix %d x %d:\n", r, c);
    for (int i = 0; i < size; i++) {
        printf("%d\t", matrix[i]);
        if ((i + 1) % c == 0) {
            printf("\n"); // Start a new row after 'c' elements
        }
    }

    // Print the transposed matrix
    printf("Transposed Matrix %d x %d:\n", c, r);
    for (int i = 0; i < c; i++) {
        for (int j = 0; j < r; j++) {
            printf("%d\t", matrix[j * c + i]);
        }
        printf("\n");
    }

    return 0; // Exit successfully
}
