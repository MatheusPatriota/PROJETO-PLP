#ifndef FINALSEMIFINAL_H_INCLUDED
#define FINALSEMIFINAL_H_INCLUDED
#include <iostream>
#include <ctime>
#include <cstdlib>
#include <vector>
#include <algorithm>
#include <locale.h>
#include <string.h>
#include <sstream>



using namespace std;

int* getMelhoresClassificados(char grupo);

void semiFinal();

void finalCampeonato();

int* partida(int time1, int time2,int timeJogaEmCasa);




using namespace std;

// Metodo para converter string para inteiro
int string_to_int(string text){
    stringstream r(text);
    int resul = 0;
    r >> resul;
    return resul;
}

// Metodo que converte um inteiro para string
string int_to_string(int num){
    stringstream ss;
    ss << num;
    string resul;
    ss >> resul;
    return resul;
}

// Metodo que realiza o sorteio de cinco times para cada grupo e retorna o resultado do sorteio (string)
string SorteiroFaseDeGrupos(string times[3][10], string grupoA[7][5], string grupoB[7][5]){

    string resul = "";

    vector <int> indices;  // indices dos times escolhidos para o grupoA
    indices.push_back(0); indices.push_back(5);
    indices.push_back(1); indices.push_back(6);
    indices.push_back(2); indices.push_back(7);
    indices.push_back(3); indices.push_back(8);
    indices.push_back(4); indices.push_back(9);


    resul += "Resultado do sorteio no Grupo A:\n";
    int cont1 = 0;
    while(cont1 < 5){
        random_shuffle(indices.begin(), indices.end());
        int x = indices.back();
        indices.pop_back();
        grupoA[0][cont1] = times[0][x];
        resul += "- " + grupoA[0][cont1] + "\n";
        cont1++;
    }

    resul += "\nResultado do sorteio no Grupo B:\n";

    int cont2 = 0;
    while(cont2 < 5){
        random_shuffle(indices.begin(), indices.end());
        int x = indices.back();
        indices.pop_back();
        grupoB[0][cont2] = times[0][x];
        resul += "- " + grupoB[0][cont2] + "\n";
        cont2++;
    }

    return resul;
}

// O metodo esta recebendo os times para posteriormente alterar os atributos de cada time apos cada jogo (lembrano que falta atualizar)
// os atributos dos times apos cada partida
vector<string> RealizandoOsJogosDaFaseDeGrupos(string times[7][10], string grupoA[7][5], string grupoB[7][5]){

    vector <string> JogosDeCadaTime;

    // Realizando jogos do grupoA
    for(int i = 0; i < 5; i++){
            string aux = "";
        for(int j = 0; j < 5; j++){
            // aqui ficaria a chamada do metodo que calcularia os gols de cada time para serem usados abaixo
            int gols_time1 = rand() % 5;
            int gols_time2 = rand() % 5;

            if(gols_time1 > gols_time2){
                aux += grupoA[0][i] + " x " + grupoB[0][j] + " : C" + "\n"; // Se o time de casa ganhou
            }
            else if(gols_time2 > gols_time1) {
                aux += grupoA[0][i] + " x " + grupoB[0][j] + " : F" + "\n"; // Se o time de fora ganhou
            }
            else {
                aux += grupoA[0][i] + " x " + grupoB[0][j] + " : E" + "\n"; // Se houver empate
            }

            if(gols_time1 > gols_time2){
                // Atualizando dados do time1
                grupoA[1][i] = int_to_string(string_to_int(grupoA[1][i]) + 3); // Pontos
                grupoA[2][i] = int_to_string(string_to_int(grupoA[2][i]) + 1); // Partidas
                grupoA[3][i] = int_to_string(string_to_int(grupoA[3][i]) + 1); // Vitorias
                grupoA[6][i] = int_to_string(string_to_int(grupoA[6][i]) + gols_time1); // Gols

                // Atualizando dados do time2
                grupoB[2][j] = int_to_string(string_to_int(grupoB[2][j]) + 1); // Partidas
                grupoB[5][j] = int_to_string(string_to_int(grupoB[5][j]) + 1); // Derrotas
                grupoB[6][j] = int_to_string(string_to_int(grupoB[6][j]) + gols_time2); // Gols
            }
            else if(gols_time2 > gols_time1){
                // Atualizando dados do time1
                grupoB[1][j] = int_to_string(string_to_int(grupoB[1][j]) + 3); // Pontos
                grupoB[2][j] = int_to_string(string_to_int(grupoB[2][j]) + 1); // Partidas
                grupoB[3][j] = int_to_string(string_to_int(grupoB[3][j]) + 1); // Vitorias
                grupoB[6][j] = int_to_string(string_to_int(grupoB[6][j]) + gols_time2); // Gols

                // Atualizando dados do time2
                grupoA[2][i] = int_to_string(string_to_int(grupoA[2][i]) + 1); // Partidas
                grupoA[5][i] = int_to_string(string_to_int(grupoA[5][i]) + 1); // Derrotas
                grupoA[6][i] = int_to_string(string_to_int(grupoA[6][i]) + gols_time1); // Gols
            }
            else {
                // Atualizando dados do time1
                grupoA[1][i] = int_to_string(string_to_int(grupoA[1][i]) + 1); // Pontos
                grupoA[2][i] = int_to_string(string_to_int(grupoA[2][i]) + 1); // Partidas
                grupoA[4][i] = int_to_string(string_to_int(grupoA[4][i]) + 1); // Empates
                grupoA[6][i] = int_to_string(string_to_int(grupoA[6][i]) + gols_time1); // Gols

                // Atualizando dados do time2
                grupoB[1][j] = int_to_string(string_to_int(grupoB[1][j]) + 1); // Pontos
                grupoB[2][j] = int_to_string(string_to_int(grupoB[2][j]) + 1); // Partidas
                grupoB[4][j] = int_to_string(string_to_int(grupoB[4][j]) + 1); // Empates
                grupoB[6][j] = int_to_string(string_to_int(grupoB[6][j]) + gols_time2); // Gols
            }
        }
        JogosDeCadaTime.push_back(aux);
    }

    // Realizando jogos do grupoB
    for(int i = 0; i < 5; i++){
        string aux = "";
        for(int j = 0; j < 5; j++){
            // aqui ficaria a chamada do metodo que calcularia os gols de cada time para serem usados abaixo
            int gols_time1 = rand() % 5;
            int gols_time2 = rand() % 5;

            if(gols_time1 > gols_time2){
                aux += grupoB[0][i] + " x " + grupoA[0][j] + " : C" + "\n"; // Se o time de casa ganhou
            }
            else if(gols_time2 > gols_time1) {
                aux += grupoB[0][i] + " x " + grupoA[0][j] + " : F" + "\n"; // Se o time de fora ganhou
            }
            else {
                aux += grupoB[0][i] + " x " + grupoA[0][j] + " : E" + "\n"; // Se houve empate
            }

            if(gols_time1 > gols_time2){
                // Atualizando dados do time1
                grupoB[1][i] = int_to_string(string_to_int(grupoB[1][i]) + 3); // Pontos
                grupoB[2][i] = int_to_string(string_to_int(grupoB[2][i]) + 1); // Partidas
                grupoB[3][i] = int_to_string(string_to_int(grupoB[3][i]) + 1); // Vitorias
                grupoB[6][i] = int_to_string(string_to_int(grupoB[6][i]) + gols_time1); // Gols

                // Atualizando dados do time2
                grupoA[2][j] = int_to_string(string_to_int(grupoA[2][j]) + 1); // Partidas
                grupoA[5][j] = int_to_string(string_to_int(grupoA[5][j]) + 1); // Derrotas
                grupoA[6][j] = int_to_string(string_to_int(grupoA[6][j]) + gols_time2); // Gols
            }
            else if(gols_time2 > gols_time1){
                // Atualizando dados do time1
                grupoA[1][j] = int_to_string(string_to_int(grupoA[1][j]) + 3); // Pontos
                grupoA[2][j] = int_to_string(string_to_int(grupoA[2][j]) + 1); // Partidas
                grupoA[3][j] = int_to_string(string_to_int(grupoA[3][j]) + 1); // Vitorias
                grupoA[6][j] = int_to_string(string_to_int(grupoA[6][j]) + gols_time2); // Gols

                // Atualizando dados do time2
                grupoB[2][i] = int_to_string(string_to_int(grupoB[2][i]) + 1); // Partidas
                grupoB[5][i] = int_to_string(string_to_int(grupoB[5][i]) + 1); // Derrotas
                grupoB[6][i] = int_to_string(string_to_int(grupoB[6][i]) + gols_time1); // Gols
            }
            else {
                // Atualizando dados do time1
                grupoB[1][i] = int_to_string(string_to_int(grupoB[1][i]) + 1); // Pontos
                grupoB[2][i] = int_to_string(string_to_int(grupoB[2][i]) + 1); // Partidas
                grupoB[4][i] = int_to_string(string_to_int(grupoB[4][i]) + 1); // Empates
                grupoB[6][i] = int_to_string(string_to_int(grupoB[6][i]) + gols_time1); // Gols

                // Atualizando dados do time2
                grupoA[1][j] = int_to_string(string_to_int(grupoA[1][j]) + 1); // Pontos
                grupoA[2][j] = int_to_string(string_to_int(grupoA[2][j]) + 1); // Partidas
                grupoA[4][j] = int_to_string(string_to_int(grupoA[4][j]) + 1); // Empates
                grupoA[6][j] = int_to_string(string_to_int(grupoA[6][j]) + gols_time2); // Gols
            }
        }
        JogosDeCadaTime.push_back(aux);
    }
    return JogosDeCadaTime;
}

// Metodo que retorna uma string com a situação atual de um grupo com os times ordenados corretamente de acordo com seus pontos
void OrdenaGrupoPelaQuantidadeDePontos(string grupo[7][5], int times[5]){

    string pontos[5] = {grupo[1][0], grupo[1][1], grupo[1][2], grupo[1][3], grupo[1][4]};

    for(int i = 0; i < 5; i++){
        int maior = -1;
        int index = -1;
        for(int j = 0; j < 5; j++){
            if(pontos[j] != ""){
                int p1_inteiro = string_to_int(pontos[j]);
                if(p1_inteiro > maior){
                    maior = p1_inteiro;
                    index = j;
                }
                else if(p1_inteiro == maior) { // Se os pontos forem iguais eu olho quem tem mais gols acumulados
                    int gols_time1 = string_to_int(grupo[6][index]);
                    int gols_time2 = string_to_int(grupo[6][j]);
                    if(gols_time2 > gols_time1){
                        maior = p1_inteiro;
                        index = j;
                    }
                }
            }
        }
        pontos[index] = "";
        times[i] = index;
    }
}

// Metodo que sera usado para exiibir os times de cada grupo na ordem certa (pelos pontos com criterio de desempate por gols)
string getGrupoOrdenado(string grupo[7][5], string qual_grupo){

    int t[5] = {0,1,2,3,4};
    OrdenaGrupoPelaQuantidadeDePontos(grupo, t);

    // Classificação , pontos, jogos, vitorias, empates, derrotas e gols;
    string resul = "Classificação: Grupo "+ qual_grupo +"         Pontos      Jogos      Vitorias      Empates      Derrotas      Gols\n";

    for (int i = 0; i < 5; i++){

        string pontos = grupo[1][t[i]];
        if(pontos.size() < 2){
            pontos += " ";
        }
        string time = grupo[0][t[i]];
        if(time.size() < 20){
            for(int i = time.size(); i <= 20; i++){
                time += " ";
            }
        }
        string partidas = grupo[2][t[i]];
        if(partidas.size() < 2){
            partidas += " ";
        }
        string vitorias = grupo[3][t[i]];
        if(vitorias.size() < 2){
            vitorias += " ";
        }
        string empates = grupo[4][t[i]];
        if(empates.size() < 2){
            empates += " ";
        }
        string derrotas = grupo[5][t[i]];
        if(derrotas.size() < 2){
            derrotas += " ";
        }
        string gols = grupo[6][t[i]];

        resul += int_to_string(i+1) + "º " + time + "         " + pontos + "          " + partidas + "          " + vitorias + "            " + empates + "           " + derrotas + "          " + gols + "\n";
    }

    return resul;
}

// Metodo que retorna os times que se classificaram para proxima fase do campeonato (semifinal)
vector<int> getClassificadosParaFinal(string grupo[7][5]){

    string pontos[5] = {grupo[1][0], grupo[1][1], grupo[1][2], grupo[1][3], grupo[1][4]};
    vector<int> classificados;

    for(int i = 0; i < 2; i++){
        int maior = -1;
        int index = -1;
        for(int j = 0; j < 5; j++){
            if(pontos[j] != ""){
                int p1_inteiro = string_to_int(pontos[j]);
                if(p1_inteiro > maior){
                    maior = p1_inteiro;
                    index = j;
                }
                else if(p1_inteiro == maior) { // Se os pontos forem iguais eu olho quem tem mais gols acumulados
                    int gols_time1 = string_to_int(grupo[6][index]);
                    int gols_time2 = string_to_int(grupo[6][j]);
                    if(gols_time2 > gols_time1){
                        maior = p1_inteiro;
                        index = j;
                    }
                }
            }
        }
        pontos[index] = "";
        classificados.push_back(index);
    }

    return classificados;
}




#endif // FINALSEMIFINAL_H_INCLUDED
