#include <fstream>
#include <iostream>
#include <random>
using namespace std;

int main()
{
    int graph[1024] = {0};
    srand(time(NULL));
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<int> distrib(1, 200);  // 随机数范围，也可以改分布情况
    int n;
    cin >> n;  // 输入点数
    for (int i = 0; i < n; i++)
        for (int j = 0; j < i; j++)
        {
            if (i == j)
                continue;
            graph[i * 32 + j] = unsigned(distrib(gen));
            if (graph[i * 32 + j] < 60 && graph[i * 32 + j] > 40)  // 用于调整删掉多少边
                graph[i * 32 + j] = -1;
            graph[j * 32 + i] = graph[i * 32 + j];
        }
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
        {
            cout << graph[i * 32 + j] << " ";
        }
        cout << endl;
    ofstream fout("test.dat", ios::binary);
    fout.write((char*)&n, sizeof(int));
    fout.write((char*)graph, sizeof(int) * 32 * 32);
    fout.close();

    ofstream fout2("test2.txt");
    fout2 << hex;
    fout2 << n << endl;
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            fout2 << " " << graph[i * 32 + j] << endl;
        }
    }
    fout2.close();
}