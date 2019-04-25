#include <iostream>
#include <ctime>
#include <cstdlib>
#include <vector>
#include <algorithm>
#include <locale.h>
#include <string.h>
#include <sstream>

#ifndef FASEDEGRUPOS_HPP
#define FASEDEGRUPOS_HPP

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
string SorteiroFaseDeGrupos(string times[10][8], string grupoA[7][5], string grupoB[7][5]){

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
        grupoA[0][cont1] = times[x][0];
        resul += "- " + grupoA[0][cont1] + "\n";
        cont1++;
    }

    resul += "\nResultado do sorteio no Grupo B:\n";

    int cont2 = 0;
    while(cont2 < 5){
        random_shuffle(indices.begin(), indices.end());
        int x = indices.back();
        indices.pop_back();
        grupoB[0][cont2] = times[x][0];
        resul += "- " + grupoB[0][cont2] + "\n";
        cont2++;
    }

    return resul;
}

string RealizaRodadasDaFaseDeGrupos(string times[10][8], string grupoA[7][5], string grupoB[7][5], int TimeX, int TimeY){
     string aux = "";

    // aqui ficaria a chamada do metodo que calcularia os gols de cada time para serem usados abaixo
    int gols_time1 = rand() % 5;
    int gols_time2 = rand() % 5;

    if(gols_time1 > gols_time2){
        aux += grupoA[0][TimeX] + " x " + grupoB[0][TimeY] + " : C" + "\n"; // Se o time de casa ganhou
    }
    else if(gols_time2 > gols_time1) {
        aux += grupoA[0][TimeX] + " x " + grupoB[0][TimeY] + " : F" + "\n"; // Se o time de fora ganhou
    }
    else {
        aux += grupoA[0][TimeX] + " x " + grupoB[0][TimeY] + " : E" + "\n"; // Se houver empate
    }

    if(gols_time1 > gols_time2){
        // Atualizando dados do time1
        grupoA[1][TimeX] = int_to_string(string_to_int(grupoA[1][TimeX]) + 3); // Pontos
        grupoA[2][TimeX] = int_to_string(string_to_int(grupoA[2][TimeX]) + 1); // Partidas
        grupoA[3][TimeX] = int_to_string(string_to_int(grupoA[3][TimeX]) + 1); // Vitorias
        grupoA[6][TimeX] = int_to_string(string_to_int(grupoA[6][TimeX]) + gols_time1); // Gols

        // Atualizando dados do time2
        grupoB[2][TimeY] = int_to_string(string_to_int(grupoB[2][TimeY]) + 1); // Partidas
        grupoB[5][TimeY] = int_to_string(string_to_int(grupoB[5][TimeY]) + 1); // Derrotas
        grupoB[6][TimeY] = int_to_string(string_to_int(grupoB[6][TimeY]) + gols_time2); // Gols
    }
    else if(gols_time2 > gols_time1){
        // Atualizando dados do time1
        grupoB[1][TimeY] = int_to_string(string_to_int(grupoB[1][TimeY]) + 3); // Pontos
        grupoB[2][TimeY] = int_to_string(string_to_int(grupoB[2][TimeY]) + 1); // Partidas
        grupoB[3][TimeY] = int_to_string(string_to_int(grupoB[3][TimeY]) + 1); // Vitorias
        grupoB[6][TimeY] = int_to_string(string_to_int(grupoB[6][TimeY]) + gols_time2); // Gols

        // Atualizando dados do time2
        grupoA[2][TimeX] = int_to_string(string_to_int(grupoA[2][TimeX]) + 1); // Partidas
        grupoA[5][TimeX] = int_to_string(string_to_int(grupoA[5][TimeX]) + 1); // Derrotas
        grupoA[6][TimeX] = int_to_string(string_to_int(grupoA[6][TimeX]) + gols_time1); // Gols
    }
    else {
        // Atualizando dados do time1
        grupoA[1][TimeX] = int_to_string(string_to_int(grupoA[1][TimeX]) + 1); // Pontos
        grupoA[2][TimeX] = int_to_string(string_to_int(grupoA[2][TimeX]) + 1); // Partidas
        grupoA[4][TimeX] = int_to_string(string_to_int(grupoA[4][TimeX]) + 1); // Empates
        grupoA[6][TimeX] = int_to_string(string_to_int(grupoA[6][TimeX]) + gols_time1); // Gols

        // Atualizando dados do time2
        grupoB[1][TimeY] = int_to_string(string_to_int(grupoB[1][TimeY]) + 1); // Pontos
        grupoB[2][TimeY] = int_to_string(string_to_int(grupoB[2][TimeY]) + 1); // Partidas
        grupoB[4][TimeY] = int_to_string(string_to_int(grupoB[4][TimeY]) + 1); // Empates
        grupoB[6][TimeY] = int_to_string(string_to_int(grupoB[6][TimeY]) + gols_time2); // Gols
    }
    return aux;
}

// O metodo esta recebendo os times para posteriormente alterar os atributos de cada time apos cada jogo (lembrano que falta atualizar)
// os atributos dos times apos cada partida
vector<string> RealizandoOsJogosDaFaseDeGrupos(string times[10][8], string grupoA[7][5], string grupoB[7][5]){

    vector <string> JogosDeCadaTime;
    string aux = "";

    // Ida

    // Rodada 1
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 0, 0);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 1, 1);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoA, grupoB, 2, 2);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoA,  grupoB, 3, 3);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 4, 4);
    JogosDeCadaTime.push_back(aux);
    aux = "";
    // Rodada 2
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 0, 1);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 1, 2);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 2, 3);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 3, 4);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 4, 0);
    JogosDeCadaTime.push_back(aux);
    aux = "";
    // Rodada 3
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 0, 2);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 1, 3);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 2, 4);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 3, 0);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 4, 1);
    JogosDeCadaTime.push_back(aux);
    aux = "";
    // Rodada 4
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 0, 3);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 1, 4);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 2, 0);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 3, 1);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 4, 2);
    JogosDeCadaTime.push_back(aux);
    aux = "";
    // Rodada 5
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 0, 4);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 1, 0);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 2, 1);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 3, 2);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 4, 3);
    JogosDeCadaTime.push_back(aux);
    aux = "";

    // Volta

    // Rodada 6
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 0, 0);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 1, 1);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 2, 2);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 3, 3);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 4, 4);
    JogosDeCadaTime.push_back(aux);
    aux = "";
    // Rodada 7
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 1, 0);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 2, 1);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 3, 2);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 4, 3);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 0, 4);
    JogosDeCadaTime.push_back(aux);
    aux = "";
    // Rodada 8
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 2, 0);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 3, 1);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 4, 2);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 0, 3);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 1, 4);
    JogosDeCadaTime.push_back(aux);
    aux = "";
    // Rodada 9
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 3, 0);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 4, 1);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 0, 2);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 1, 3);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 2, 4);
    JogosDeCadaTime.push_back(aux);
    aux = "";

    // Rodada 10
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 4, 0);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 0, 1);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 1, 2);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 2, 3);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 3, 4);
    JogosDeCadaTime.push_back(aux);
    aux = "";

    return JogosDeCadaTime;
}

// Metodo que retorna uma string com a situa��o atual de um grupo com os times ordenados corretamente de acordo com seus pontos
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

    // Classifica��o , pontos, jogos, vitorias, empates, derrotas e gols;
    string resul = "Classifica��o: Grupo "+ qual_grupo +"         Pontos      Jogos      Vitorias      Empates      Derrotas      Gols\n";

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

        resul += int_to_string(i+1) + "� " + time + "         " + pontos + "          " + partidas + "          " + vitorias + "            " + empates + "           " + derrotas + "          " + gols + "\n";
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

// Main para testes
//main para ser passado pro main.cpp


#endif
