#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <iostream>
#include "image_processing.cpp"

using namespace std;

extern "C" void Dilation(int n, int filter_size, short *resim_org);
extern "C" void Erosion(int n, int filter_size, short *resim_org);

int main(void)
{
    int M, N, Q, i, j, filter_size;
    bool type;
    int efile;
    char org_resim[100], dil_resim[] = "dilated.pgm", ero_resim[] = "eroded.pgm";
    do
    {
        printf("Orijinal resmin yolunu (path) giriniz:\n-> ");
        scanf("%s", &org_resim);
        // system("CLS");
        efile = readImageHeader(org_resim, N, M, Q, type);
    } while (efile > 1);
    int **resim_org = resimOku(org_resim);

    printf("Orjinal Resim Yolu: \t\t\t%s\n", org_resim);

    short *resimdizi_org = (short *)malloc(N * M * sizeof(short));

    for (i = 0; i < N; i++)
        for (j = 0; j < M; j++)
            resimdizi_org[i * N + j] = (short)resim_org[i][j];

    int menu;
    printf("Yapmak istediginiz islemi giriniz...\n");
    printf("1-) Dilation\n");
    printf("2-) Erosion\n");
    printf("3-) Cikis\n> ");
    scanf("%d", &menu);
    printf("Filtre boyutunu giriniz: ");
    scanf("%d", &filter_size);

    switch (menu)
    {
    case 1:
        Dilation(N * M, filter_size, resimdizi_org);
        resimYaz(dil_resim, resimdizi_org, N, M, Q);
        break;
    case 2:
        Erosion(N * M, filter_size, resimdizi_org);
        resimYaz(ero_resim, resimdizi_org, N, M, Q);
        break;
    case 3:
        system("EXIT");
        break;
    default:
        system("EXIT");
        break;
    }

    system("PAUSE");
    return 0;
}

// void Dilation(int n, int filter_size, short *resim_org)
// {
//     // Do dialation on a square of filter_size pixels assuming the image is a square

//     int i, j, k, l;
//     short *temp = (short *)malloc(n * sizeof(short));
//     memcpy(temp, resim_org, n * sizeof(short));

//     int side = sqrt(n);

//     for (i = 0; i < side; i++)
//     {
//         for (j = 0; j < side; j++)
//         {
//             for (k = i - filter_size ; k < i + filter_size ; k++)
//             {
//                 for (l = j - filter_size ; l < j + filter_size ; l++)
//                 {
//                     if (k >= 0 && k < side && l >= 0 && l < side)
//                     {
//                         temp[i * side + j] = (((temp[i * side + j]) > (resim_org[k * side + l])) ? (temp[i * side + j]) : (resim_org[k * side + l]));
//                     }
//                 }
//             }
//         }
//     }

//     memcpy(resim_org, temp, n * sizeof(short));
//     free(temp);

//     printf("\nDilation islemi sonucunda resim \"dilated.pgm\" ismiyle olusturuldu...\n");
// }

// void Erosion(int n, int filter_size, short *resim_org)
// {
//     // Do erosion on a square of filter_size pixels assuming the image is a square

//     int i, j, k, l;
//     short *temp = (short *)malloc(n * sizeof(short));
//     memcpy(temp, resim_org, n * sizeof(short));

//     int side = sqrt(n);

//     for (i = 0; i < side; i++)
//     {
//         for (j = 0; j < side; j++)
//         {
//             for (k = i - filter_size; k < i + filter_size; k++)
//             {
//                 for (l = j - filter_size; l < j + filter_size; l++)
//                 {
//                     if (k >= 0 && k < side && l >= 0 && l < side)
//                     {
//                         temp[i * side + j] = (((temp[i * side + j]) < (resim_org[k * side + l])) ? (temp[i * side + j]) : (resim_org[k * side + l]));
//                     }
//                 }
//             }
//         }
//     }

//     memcpy(resim_org, temp, n * sizeof(short));
//     free(temp);

//     printf("\nErosion islemi sonucunda resim \"erosion.pgm\" ismiyle olusturuldu...\n");
// }