#include <bits/stdc++.h>
using namespace std;

const int MAXN = 1e6 + 10, INF = 1e9;

vector<pair<int, int>> grafo[MAXN];
priority_queue<pair<pair<long long, int>, int>, vector<pair<pair<long long, int>, int>>, greater<pair<pair<long long, int>, int>>> pq;
long long valores[MAXN], dist[MAXN], n, m, k;
bool jaFoi[MAXN];

void djikstra(int root, int who){
    dist[root] = 0;
    pq.emplace(make_pair(make_pair(dist[root], -1), root));

    while (!pq.empty())
    {   
        int current = pq.top().second;
        long long valorAtual = pq.top().first.first;
        int sistemaAtual = pq.top().first.second;

        pq.pop();
        jaFoi[current] = 1;

        
        for(int i = 0; i < grafo[current].size(); i++){

            long long preco = valorAtual;
            int sistema = grafo[current][i].second;
            int vertice = grafo[current][i].first;
            
            if(jaFoi[vertice]) continue;
            
            if(sistema != sistemaAtual){
                preco += valores[sistema];
            }

            if(dist[vertice] > preco){
                dist[vertice] = preco;
                pq.emplace(make_pair(make_pair(preco, sistema), vertice));
            }
        }
    }
}

int main(){

    for(int i = 0; i < MAXN; i++){
        dist[i] = INF;
    }

    cin >> n >> m >> k;
    
    for(int i = 0; i < k; i++){
        cin >> valores[i];
    }

    int u, l, s;

    for(int i = 0; i < m; i++){
        cin >> u >> l >> s;

        u--;
        l--;
        s--;

        grafo[u].push_back({l, s});
        grafo[l].push_back({u, s});
    }

    int x, y;

    cin >> x >> y;

    x--;
    y--;

    djikstra(x, y);

    if(dist[y] == INF){
        cout << -1 << endl;
    }else{
        cout << dist[y] << endl;
    }


    return 0;
}