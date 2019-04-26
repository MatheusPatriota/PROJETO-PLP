#include <iostream>
#include <ctime>
#include <cstdlib>
#include <vector>
#include <algorithm>
#include <locale.h>
#include <string.h>
#include <sstream>
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

int getIdTimeGrupo(string times[10][7], string time){
    int id = -1;
    for(int i = 0; i < 10; i++){
        if(times[i][0] == time){
            id = i;
            break;
        }
    }
    return id;

}


void transferencia(string times[10][7], string jogadores[25][4], int cont){
    srand((unsigned)time(NULL));
    int aux1 = rand() % cont-1;

    for(int i = 0; i < 4; i++){
        jogadores[aux1][i] = jogadores[cont][i];
    }

    int aux2 = rand() % (cont - 2);

    int timeEscolhido = rand() % 10;
    int timeEscolhido2 = rand() % 10;


    cout<<"Mercado de Transferencia: \n"<<endl;

    if (jogadores[aux1][1] == "A"){
        times[timeEscolhido][1] = string_to_int(times[timeEscolhido][1]) + string_to_int(jogadores[aux1][2]);
        cout<<"O Atacante " + jogadores[aux1][0] + " se transferiu para o " + times[timeEscolhido][0] + " numa transação de R$" + jogadores[aux1][3]<<endl;
    }else if (jogadores[aux1][1] == "Z"){
        times[timeEscolhido][2] = string_to_int(times[timeEscolhido][2]) + string_to_int(jogadores[aux1][2]);
        cout<<"O Zagueiro " + jogadores[aux1][0] + " se transferiu para o " + times[timeEscolhido][0] + " numa transação de R$" + jogadores[aux1][3]<<endl;
    }else if (jogadores[aux1][1] == "M"){
        times[timeEscolhido][3] = string_to_int(times[timeEscolhido][3]) + string_to_int(jogadores[aux1][2]);
        cout<<"O Meio-Campista " + jogadores[aux1][0] + " se transferiu para o " + times[timeEscolhido][0] + " numa transação de R$" + jogadores[aux1][3]<<endl;
    }

    for(int i = 0; i < 4; i++){
        jogadores[aux1][i] = jogadores[cont][i];
    }

    if (jogadores[aux2][1] == "A"){
        times[timeEscolhido2][1] = string_to_int(times[timeEscolhido2][1]) + string_to_int(jogadores[aux2][2]);
        cout<<"O Atacante " + jogadores[aux2][0] + " se transferiu para o " + times[timeEscolhido2][0] + " numa transação de R$" + jogadores[aux2][3]<<endl;
    }else if (jogadores[aux2][1] == "Z"){
        times[timeEscolhido2][2] = string_to_int(times[timeEscolhido2][2]) + string_to_int(jogadores[aux2][2]);
        cout<<"O Zagueiro " + jogadores[aux2][0] + " se transferiu para o " + times[timeEscolhido2][0] + " numa transação de R$" + jogadores[aux2][3]<<endl;
    }else if (jogadores[2][1] == "M"){
        times[timeEscolhido2][3] = string_to_int(times[timeEscolhido2][3]) + string_to_int(jogadores[aux2][2]);
        cout<<"O Meio-Campista " + jogadores[aux2][0] + " se transferiu para o " + times[timeEscolhido2][0] + " numa transação de R$" + jogadores[aux2][3]<<endl;
    }

    for(int i = 0; i < 4; i++){
        jogadores[aux2][i] = jogadores[cont-1][i];
    }

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



//Calculo da for�a de um time
int calculoDeForca(int somatorio, int torcida, float porcentagemDaTorcida){

    // equivale a 70% da for�a do time
	somatorio = (int) (somatorio * 0.7);

	//a porcentagem da torcida � passada como parametro
	torcida = torcida * porcentagemDaTorcida;

	//retorna a for�a total do time
	return somatorio + torcida;
}


//Calcula a for�a de dois times, retornando um array no final, onde a posi��o 0 � o resultado do time 1 e
//a posi��o 1 � o resultado do segundo time
int* resultadoFinal(int time1, int time2){
    srand((unsigned)time(NULL));
    int* result;


    //condi��o para caso um time seja 4 vezes superior ao outro, para que haja chances de acontecer zebras
	if(time1 > 3 * time2){
		time2 = time2 + (rand()% (time1 - time2 + 30));
	}if (time2 > 3 * time1){
		time1 = time1 + (rand()% (time2 - time1 + 30));
	}


	// reduz a for�a do time para uma casa decimal
	int auxTime1 = (int) (time1 * 0.01);
	int auxTime2 = (int) (time2 * 0.01);


	//calcula os resultados
	int random1 = ((-auxTime1) + (rand()% (auxTime1 * 2 -1)));
	int random2 = ((-auxTime2)  + (rand()% (auxTime2 * 2 - 1)));


	auxTime1 += random1;
	auxTime2 += random2;


	// aloca os resultados em um vetor para ser usado futuramente.
	result = (int*)malloc(2*sizeof(int));
	result[0] = auxTime1;
	result[1] = auxTime2;
    return result;
}


int* calculoDaAposta(int time1, int time2){
    int aux1, aux2;


    if (time1 > time2){
        aux1 = 500 - (time1 * 0.15);
        aux2 = 500 + (time2 *0.35);
    }
    else if (time2 > time1){
        aux1 = 500 + (time1 *0.35);
        aux2 = 500 - (time2 *0.15);
    }


    int* result = (int*)malloc(2*sizeof(int));
    result[0] = aux1;
    result[1] = aux2;


    return result;
}


void exibeJogosDaRodada(string aux, string cont){
    cout<<"JOGOS DA RODADA: " + cont + "\n"<<endl;
    cout<<aux<<endl;


}

int* simulaAposta(string times[10][7], string aux, string aux2,  string cont){
    exibeJogosDaRodada(aux, cont);
    string nomeTime = "";
    int* apost;
    cout<<aux2<<endl;
    int id = -1;

    cout<<"A cada rodada o usuário tem direito a 2 apostas, gostaria de apostar? S para sim, N para nao" <<endl;
    char s;
    cin>>s;

    apost = (int*)malloc(2*sizeof(int));

    if (s == 'S'){
        cout<<"Digite o nome do time que gostaria de apostar: "<<endl;

        cin>>nomeTime;

        id = getIdTimeGrupo(times, nomeTime);

        if (id == -1){
            cout<<"Time Invalido"<<endl;
            apost[0] = -1;
            apost[1] = -1;
        }else{
            apost[0] = id;
            cout<<"Gostaria de realizar a segunda aposta? "<<endl;
            cin>>s;
            if (s == 'S'){
                nomeTime = "";
                cout<<"Digite o nome do time que gostaria de apostar: "<<endl;
                cin>>nomeTime;
                id = -1;

                id = getIdTimeGrupo(times, nomeTime);
                if (id == -1){
                    cout<<"Time Invalido"<<endl;
                    apost[1] = -1;
                }else{
                    apost[1] = id;
                }
            }else{
                apost[1] = -1;
            }

        }

    }else{
        apost[0] = -1;
        apost[1] = -1;
    }

    cout<<"\nApostas Encerradas\n"<<endl;
    return apost;
}


void exibeResultadoRodada(string aux, string grupoA[7][5], string grupoB[7][5], string cont){

    cout << "Rodada " + cont + "\n" + aux << "\n" << endl;

    cout << "---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------" << endl;
    string resul1 = getGrupoOrdenado(grupoA, "A");
    string resul2 = getGrupoOrdenado(grupoB, "B");
    cout <<  resul1;
    cout << "---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------" << endl;
    cout <<  resul2<<endl;
    cout<<"\n"<<endl;

}


// Metodo que realiza o sorteio de cinco times para cada grupo e retorna o resultado do sorteio (string)
string SorteiroFaseDeGrupos(string timesAtributos[10][7], string grupoA[7][5], string grupoB[7][5]){

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
        grupoA[0][cont1] = timesAtributos[x][0];
        resul += "- " + grupoA[0][cont1] + "\n";
        cont1++;
    }

    resul += "\nResultado do sorteio no Grupo B:\n";

    int cont2 = 0;
    while(cont2 < 5){
        random_shuffle(indices.begin(), indices.end());
        int x = indices.back();
        indices.pop_back();
        grupoB[0][cont2] = timesAtributos[x][0];
        resul += "- " + grupoB[0][cont2] + "\n";
        cont2++;
    }

    return resul;
}

int somatorioDasForcas(string times[10][7], int idTime){
    int resultado = 0;
    for(int i = 1; i < 6; i++){
		resultado += string_to_int(times[idTime][i]);
	}
	return resultado;
}

string RealizaRodadasDaFaseDeGrupos(string times[10][7], string grupoA[7][5], string grupoB[7][5], int TimeX, int TimeY, int idTimex, int idTimey, int auxTimes[10]){
    srand((unsigned)time(NULL));
     string aux = "";
     int* resultadoFinalPartida;
     int forcaTime1, forcaTime2;

    // aqui ficaria a chamada do metodo que calcularia os gols de cada time para serem usados abaixo

    //forca do time1
    int resultado1 = somatorioDasForcas(times, idTimex);
	forcaTime1 = calculoDeForca(resultado1, string_to_int(times[idTimex][6]), 0.7);


	//forca do time2
	int resultado2 = somatorioDasForcas(times, idTimey);
	forcaTime2 = calculoDeForca(resultado2, string_to_int(times[idTimey][6]), 0.3);


	resultadoFinalPartida = resultadoFinal(forcaTime1, forcaTime2);


	//gols dos times
    int gols_time1 = resultadoFinalPartida[0];
    int gols_time2 = resultadoFinalPartida[1];

    if(gols_time1 > gols_time2){
        auxTimes[idTimex] = 1;
        aux += grupoA[0][TimeX] + " x " + grupoB[0][TimeY] + " : C" + "\n"; // Se o time de casa ganhou
    }
    else if(gols_time2 > gols_time1) {
        auxTimes[idTimey] = 1;
        aux += grupoA[0][TimeX] + " x " + grupoB[0][TimeY] + " : F" + "\n"; // Se o time de fora ganhou
    }
    else {
        aux += grupoA[0][TimeX] + " x " + grupoB[0][TimeY] + " : E" + "\n"; // Se houver empate
    }

    //atualizando as forças dos times de acordo com os jogos
    times[idTimex][1] = int_to_string(string_to_int(times[idTimex][1]) + gols_time1);
    times[idTimex][2] = int_to_string(string_to_int(times[idTimex][2]) - gols_time2);
    times[idTimex][5] = int_to_string(string_to_int(times[idTimex][5]) - 1);

    if(string_to_int(times[idTimex][2]) < 30){
        times[idTimex][2] = "30";
    }

    times[idTimey][1] = int_to_string(string_to_int(times[idTimey][1]) + gols_time2);
    times[idTimey][2] = int_to_string(string_to_int(times[idTimey][2]) - gols_time1);
    times[idTimey][5] = int_to_string(string_to_int(times[idTimey][5]) - 1);

    if(string_to_int(times[idTimey][2]) < 30){
        times[idTimey][2] = "30";
    }


    if(gols_time1 > gols_time2){

        //atualizando a torcida e a confiança
        times[TimeX][4] = int_to_string(string_to_int(times[TimeX][4]) + 1);
        times[TimeX][6] = int_to_string(string_to_int(times[TimeX][6]) + 1);



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

        //atualizando a torcida e a confiança
        times[TimeX][4] = int_to_string(string_to_int(times[TimeX][4]) - 1);
        times[TimeX][6] = int_to_string(string_to_int(times[TimeX][6]) - 1);


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
vector<string> RealizandoOsJogosDaFaseDeGrupos(string times[10][7], string grupoA[7][5], string grupoB[7][5], string jogadores[25][4]){
    int* aposta;
    int valorDaAposta = 2000;

    vector <string> JogosDeCadaTime;
    string aux = "";
    string aux2 = "";
    string aux3 = "";

    // Ida

    // Rodada 1
    transferencia(times, jogadores, 24);
    int valorDoJogo[10] = {0,0,0,0,0,0,0,0,0,0};
    int auxTimes[10] = {0,0,0,0,0,0,0,0,0,0};
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 0, 0, getIdTimeGrupo(times, grupoA[0][0]), getIdTimeGrupo(times, grupoB[0][0]), auxTimes);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 1, 1, getIdTimeGrupo(times, grupoA[0][1]), getIdTimeGrupo(times, grupoB[0][1]),auxTimes);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoA, grupoB, 2, 2, getIdTimeGrupo(times, grupoA[0][2]),getIdTimeGrupo(times, grupoB[0][2]),auxTimes);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoA,  grupoB, 3, 3, getIdTimeGrupo(times, grupoA[0][3]), getIdTimeGrupo(times, grupoB[0][3]),auxTimes);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 4, 4, getIdTimeGrupo(times, grupoA[0][4]), getIdTimeGrupo(times, grupoB[0][4]),auxTimes);


    aux2 += grupoA[0][0] + "  X  " + grupoB[0][0] + "\n";
    aux2 += grupoA[0][1] + "  X  " + grupoB[0][1] + "\n";
    aux2 += grupoA[0][2] + "  X  " + grupoB[0][2] + "\n";
    aux2 += grupoA[0][3] + "  X  " + grupoB[0][3] + "\n";
    aux2 += grupoA[0][4] + "  X  " + grupoB[0][4] + "\n";



    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][0])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][0])));
    valorDoJogo[getIdTimeGrupo(times, grupoA[0][0])] = aposta[0];
    valorDoJogo[getIdTimeGrupo(times, grupoB[0][0])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][0] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][0] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][1])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][1])));
    valorDoJogo[getIdTimeGrupo(times, grupoA[0][1])] = aposta[0];
    valorDoJogo[getIdTimeGrupo(times, grupoB[0][1])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][1] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][1] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][2])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][2])));
    valorDoJogo[getIdTimeGrupo(times, grupoA[0][2])] = aposta[0];
    valorDoJogo[getIdTimeGrupo(times, grupoB[0][2])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][2] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][2] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][3])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][3])));
    valorDoJogo[getIdTimeGrupo(times, grupoA[0][3])] = aposta[0];
    valorDoJogo[getIdTimeGrupo(times, grupoB[0][3])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][3] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][3] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][4])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][4])));
    valorDoJogo[getIdTimeGrupo(times, grupoA[0][4])] = aposta[0];
    valorDoJogo[getIdTimeGrupo(times, grupoB[0][4])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][4] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][4] + ": " + int_to_string(aposta[1]) + "\n";


    int* simulacaoAposta = simulaAposta(times, aux2, aux3, "01");


    for(int i = 0; i < 2; i++){
        if( simulacaoAposta[i] != -1){

            if(auxTimes[simulacaoAposta[i]] == 1){
                valorDaAposta += valorDoJogo[simulacaoAposta[i]];
                cout<<"O usuario ganhou " + int_to_string(valorDoJogo[simulacaoAposta[i]])  + " por apostar no " + times[simulacaoAposta[i]][0] <<endl;
            }
            else{
                cout<<"O usuario perdeu 500 reais por apostar no " + times[simulacaoAposta[i]][0]<<endl;
                valorDaAposta -= 500;
            }
        }else{
            break;
        }
    }

    JogosDeCadaTime.push_back(aux);


    exibeResultadoRodada(aux, grupoA, grupoB, "01");

    cout<<"Saldo total do usuario depois dessa rodada: " + int_to_string(valorDaAposta) + "\n\n"<<endl;

    // Rodada 2
    aux = "";
    aux2 = "";
    aux3 = "";
    int auxTimes1[10] = {0,0,0,0,0,0,0,0,0,0};
    int valorDoJogo1[10] = {0,0,0,0,0,0,0,0,0,0};

    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 0, 2, getIdTimeGrupo(times, grupoA[0][0]), getIdTimeGrupo(times, grupoB[0][2]), auxTimes1);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 1, 3, getIdTimeGrupo(times, grupoA[0][1]), getIdTimeGrupo(times, grupoB[0][3]),auxTimes1);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoA, grupoB, 2, 4, getIdTimeGrupo(times, grupoA[0][2]),getIdTimeGrupo(times, grupoB[0][4]),auxTimes1);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoA,  grupoB, 3, 0, getIdTimeGrupo(times, grupoA[0][3]), getIdTimeGrupo(times, grupoB[0][0]),auxTimes1);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 4, 1, getIdTimeGrupo(times, grupoA[0][4]), getIdTimeGrupo(times, grupoB[0][1]),auxTimes1);


    aux2 += grupoA[0][0] + "  X  " + grupoB[0][2] + "\n";
    aux2 += grupoA[0][1] + "  X  " + grupoB[0][3] + "\n";
    aux2 += grupoA[0][2] + "  X  " + grupoB[0][4] + "\n";
    aux2 += grupoA[0][3] + "  X  " + grupoB[0][0] + "\n";
    aux2 += grupoA[0][4] + "  X  " + grupoB[0][1] + "\n";

    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][0])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][2])));
    valorDoJogo1[getIdTimeGrupo(times, grupoA[0][0])] = aposta[0];
    valorDoJogo1[getIdTimeGrupo(times, grupoB[0][2])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][0] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][2] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][1])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][3])));
    valorDoJogo1[getIdTimeGrupo(times, grupoA[0][1])] = aposta[0];
    valorDoJogo1[getIdTimeGrupo(times, grupoB[0][3])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][1] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][3] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][2])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][4])));
    valorDoJogo1[getIdTimeGrupo(times, grupoA[0][2])] = aposta[0];
    valorDoJogo[getIdTimeGrupo(times, grupoB[0][4])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][2] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][4] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][3])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][1])));
    valorDoJogo1[getIdTimeGrupo(times, grupoA[0][3])] = aposta[0];
    valorDoJogo1[getIdTimeGrupo(times, grupoB[0][4])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][3] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][1] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][4])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][2])));
    valorDoJogo1[getIdTimeGrupo(times, grupoA[0][4])] = aposta[0];
    valorDoJogo1[getIdTimeGrupo(times, grupoB[0][2])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][4] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][2] + ": " + int_to_string(aposta[1]) + "\n";


    simulacaoAposta = simulaAposta(times, aux2, aux3, "02");

    for(int i = 0; i < 2; i++){
        if( simulacaoAposta[i] != -1){
            if(auxTimes1[simulacaoAposta[i]] == 1){
                valorDaAposta += valorDoJogo1[simulacaoAposta[i]];
                cout<<"O usuario ganhou " + int_to_string(valorDoJogo1[simulacaoAposta[i]])  + " por apostar no " + times[simulacaoAposta[i]][0]<<endl;
            }
            else{
                cout<<"O usuario perdeu 500 reais por apostar no " + times[simulacaoAposta[i]][0]<<endl;
                valorDaAposta -= 500;
            }
        }else{
            break;
        }
    }

    JogosDeCadaTime.push_back(aux);


    exibeResultadoRodada(aux, grupoA, grupoB, "02");

    cout<<"Saldo total do usuario depois dessa rodada: " + int_to_string(valorDaAposta) + "\n\n"<<endl;


    // Rodada 3
    aux = "";
    aux2 = "";
    aux3 = "";
    int auxTimes2[10] = {0,0,0,0,0,0,0,0,0,0};
    int valorDoJogo2[10] = {0,0,0,0,0,0,0,0,0,0};

    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 0, 1, getIdTimeGrupo(times, grupoA[0][0]), getIdTimeGrupo(times, grupoB[0][1]), auxTimes2);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 1, 2, getIdTimeGrupo(times, grupoA[0][1]), getIdTimeGrupo(times, grupoB[0][2]),auxTimes2);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoA, grupoB, 2, 3, getIdTimeGrupo(times, grupoA[0][2]),getIdTimeGrupo(times, grupoB[0][3]),auxTimes2);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoA,  grupoB, 3, 4, getIdTimeGrupo(times, grupoA[0][3]), getIdTimeGrupo(times, grupoB[0][4]),auxTimes2);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 4, 0, getIdTimeGrupo(times, grupoA[0][4]), getIdTimeGrupo(times, grupoB[0][0]),auxTimes2);


    aux2 += grupoA[0][0] + "  X  " + grupoB[0][1] + "\n";
    aux2 += grupoA[0][1] + "  X  " + grupoB[0][2] + "\n";
    aux2 += grupoA[0][2] + "  X  " + grupoB[0][3] + "\n";
    aux2 += grupoA[0][3] + "  X  " + grupoB[0][4] + "\n";
    aux2 += grupoA[0][4] + "  X  " + grupoB[0][0] + "\n";



    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][0])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][1])));
    valorDoJogo2[getIdTimeGrupo(times, grupoA[0][0])] = aposta[0];
    valorDoJogo2[getIdTimeGrupo(times, grupoB[0][1])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][0] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][1] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][1])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][2])));
    valorDoJogo2[getIdTimeGrupo(times, grupoA[0][1])] = aposta[0];
    valorDoJogo2[getIdTimeGrupo(times, grupoB[0][1])] = aposta[2];
    aux3 += "Lucro por apostar no " + grupoA[0][1] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][2] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][2])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][3])));
    valorDoJogo2[getIdTimeGrupo(times, grupoA[0][2])] = aposta[0];
    valorDoJogo2[getIdTimeGrupo(times, grupoB[0][2])] = aposta[3];
    aux3 += "Lucro por apostar no " + grupoA[0][2] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][3] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][3])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][4])));
    valorDoJogo2[getIdTimeGrupo(times, grupoA[0][3])] = aposta[0];
    valorDoJogo2[getIdTimeGrupo(times, grupoB[0][4])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][3] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][4] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][4])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][1])));
    valorDoJogo2[getIdTimeGrupo(times, grupoA[0][4])] = aposta[0];
    valorDoJogo2[getIdTimeGrupo(times, grupoB[0][1])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][4] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][1] + ": " + int_to_string(aposta[1]) + "\n";

    if(valorDaAposta > 500 && valorDaAposta < 1000){
        valorDaAposta = 1000;
        simulacaoAposta = simulaAposta(times, aux2, aux3, "03");
    }else if(valorDaAposta > 1000){
        simulacaoAposta = simulaAposta(times, aux2, aux3, "03");
    }else{
        valorDaAposta = 1000;
    }

    for(int i = 0; i < 2; i++){
        if( simulacaoAposta[i] != -1){
            if(auxTimes2[simulacaoAposta[i]] == 1){
                valorDaAposta += valorDoJogo2[simulacaoAposta[i]];
                cout<<"O usuario ganhou " + int_to_string(valorDoJogo2[simulacaoAposta[i]])  + " por apostar no " + times[simulacaoAposta[i]][0]<<endl;
            }
            else{
                cout<<"O usuario perdeu 500 reais por apostar no " + times[simulacaoAposta[i]][0]<<endl;
                valorDaAposta -= 500;
            }
        }else{
            break;
        }
    }

    JogosDeCadaTime.push_back(aux);


    exibeResultadoRodada(aux, grupoA, grupoB, "03");

    cout<<"Saldo total do usuario depois dessa rodada: " + int_to_string(valorDaAposta) + "\n\n"<<endl;


    // Rodada 4
    transferencia(times, jogadores, 24);
    aux = "";
    aux2 = "";
    aux3 = "";
    int auxTimes3[10] = {0,0,0,0,0,0,0,0,0,0};
    int valorDoJogo3[10] = {0,0,0,0,0,0,0,0,0,0};

    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 0, 3, getIdTimeGrupo(times, grupoA[0][0]), getIdTimeGrupo(times, grupoB[0][3]), auxTimes3);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 1, 4, getIdTimeGrupo(times, grupoA[0][1]), getIdTimeGrupo(times, grupoB[0][4]),auxTimes3);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoA, grupoB, 2, 0, getIdTimeGrupo(times, grupoA[0][2]),getIdTimeGrupo(times, grupoB[0][0]),auxTimes3);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoA,  grupoB, 3, 1, getIdTimeGrupo(times, grupoA[0][3]), getIdTimeGrupo(times, grupoB[0][1]),auxTimes3);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 4, 2, getIdTimeGrupo(times, grupoA[0][4]), getIdTimeGrupo(times, grupoB[0][2]),auxTimes3);


    aux2 += grupoA[0][0] + "  X  " + grupoB[0][3] + "\n";
    aux2 += grupoA[0][1] + "  X  " + grupoB[0][4] + "\n";
    aux2 += grupoA[0][2] + "  X  " + grupoB[0][0] + "\n";
    aux2 += grupoA[0][3] + "  X  " + grupoB[0][1] + "\n";
    aux2 += grupoA[0][4] + "  X  " + grupoB[0][2] + "\n";

    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][0])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][3])));
    valorDoJogo3[getIdTimeGrupo(times, grupoA[0][0])] = aposta[0];
    valorDoJogo3[getIdTimeGrupo(times, grupoB[0][3])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][0] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][3] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][1])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][4])));
    valorDoJogo3[getIdTimeGrupo(times, grupoA[0][1])] = aposta[0];
    valorDoJogo3[getIdTimeGrupo(times, grupoB[0][4])] = aposta[2];
    aux3 += "Lucro por apostar no " + grupoA[0][1] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][4] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][2])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][0])));
    valorDoJogo3[getIdTimeGrupo(times, grupoA[0][2])] = aposta[0];
    valorDoJogo3[getIdTimeGrupo(times, grupoB[0][0])] = aposta[3];
    aux3 += "Lucro por apostar no " + grupoA[0][2] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][0] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][3])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][1])));
    valorDoJogo3[getIdTimeGrupo(times, grupoA[0][3])] = aposta[0];
    valorDoJogo3[getIdTimeGrupo(times, grupoB[0][1])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][3] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][1] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][4])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][2])));
    valorDoJogo3[getIdTimeGrupo(times, grupoA[0][4])] = aposta[0];
    valorDoJogo3[getIdTimeGrupo(times, grupoB[0][2])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][4] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][2] + ": " + int_to_string(aposta[1]) + "\n";

    if(valorDaAposta > 500 && valorDaAposta < 1000){
        valorDaAposta = 1000;
        simulacaoAposta = simulaAposta(times, aux2, aux3, "04");
    }else if(valorDaAposta > 1000){
        simulacaoAposta = simulaAposta(times, aux2, aux3, "04");
    }else{
        valorDaAposta = 1000;
    }

    for(int i = 0; i < 2; i++){
        if( simulacaoAposta[i] != -1){
            if(auxTimes3[simulacaoAposta[i]] == 1){
                valorDaAposta += valorDoJogo3[simulacaoAposta[i]];
                cout<<"O usuario ganhou " + int_to_string(valorDoJogo3[simulacaoAposta[i]])  + " por apostar no " + times[simulacaoAposta[i]][0]<<endl;
            }
            else{
                cout<<"O usuario perdeu 500 reais por apostar no " + times[simulacaoAposta[i]][0]<<endl;
                valorDaAposta -= 500;
            }
        }else{
            break;
        }
    }

    JogosDeCadaTime.push_back(aux);


    exibeResultadoRodada(aux, grupoA, grupoB, "04");

    cout<<"Saldo total do usuario depois dessa rodada: " + int_to_string(valorDaAposta) + "\n\n"<<endl;



    // Rodada 5
    transferencia(times, jogadores, 20);

    aux = "";
    aux2 = "";
    aux3 = "";
    int auxTimes5[10] = {0,0,0,0,0,0,0,0,0,0};
    int valorDoJogo5[10] = {0,0,0,0,0,0,0,0,0,0};

    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 0, 4, getIdTimeGrupo(times, grupoA[0][0]), getIdTimeGrupo(times, grupoB[0][4]), auxTimes5);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 1, 0, getIdTimeGrupo(times, grupoA[0][1]), getIdTimeGrupo(times, grupoB[0][0]),auxTimes5);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoA, grupoB, 2, 1, getIdTimeGrupo(times, grupoA[0][2]),getIdTimeGrupo(times, grupoB[0][1]),auxTimes5);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoA,  grupoB, 3, 2, getIdTimeGrupo(times, grupoA[0][3]), getIdTimeGrupo(times, grupoB[0][2]),auxTimes5);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoA,  grupoB, 4, 3, getIdTimeGrupo(times, grupoA[0][4]), getIdTimeGrupo(times, grupoB[0][3]),auxTimes5);


    aux2 += grupoA[0][0] + "  X  " + grupoB[0][4] + "\n";
    aux2 += grupoA[0][1] + "  X  " + grupoB[0][0] + "\n";
    aux2 += grupoA[0][2] + "  X  " + grupoB[0][1] + "\n";
    aux2 += grupoA[0][3] + "  X  " + grupoB[0][2] + "\n";
    aux2 += grupoA[0][4] + "  X  " + grupoB[0][3] + "\n";


    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][0])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][4])));
    valorDoJogo5[getIdTimeGrupo(times, grupoA[0][0])] = aposta[0];
    valorDoJogo5[getIdTimeGrupo(times, grupoB[0][4])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][0] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][4] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][1])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][0])));
    valorDoJogo5[getIdTimeGrupo(times, grupoA[0][1])] = aposta[0];
    valorDoJogo5[getIdTimeGrupo(times, grupoB[0][4])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoA[0][1] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][0] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][2])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][1])));
    valorDoJogo5[getIdTimeGrupo(times, grupoA[0][2])] = aposta[0];
    valorDoJogo5[getIdTimeGrupo(times, grupoB[0][0])] = aposta[1];
    aux3 += "Lucro por apostar no " + grupoA[0][2] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][1] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][3])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][2])));
    valorDoJogo5[getIdTimeGrupo(times, grupoA[0][3])] = aposta[0];
    valorDoJogo5[getIdTimeGrupo(times, grupoB[0][1])] = aposta[2];
    aux3 += "Lucro por apostar no " + grupoA[0][3] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][2] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][4])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][3])));
    valorDoJogo5[getIdTimeGrupo(times, grupoA[0][4])] = aposta[0];
    valorDoJogo5[getIdTimeGrupo(times, grupoB[0][2])] = aposta[3];
    aux3 += "Lucro por apostar no " + grupoA[0][4] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoB[0][3] + ": " + int_to_string(aposta[1]) + "\n";

    if(valorDaAposta > 500 && valorDaAposta < 1000){
        valorDaAposta = 1000;
        simulacaoAposta = simulaAposta(times, aux2, aux3, "05");
    }else if(valorDaAposta > 1000){
        simulacaoAposta = simulaAposta(times, aux2, aux3, "05");
    }else{
        valorDaAposta = 1000;
    }

    for(int i = 0; i < 2; i++){
        if( simulacaoAposta[i] != -1){
            if(auxTimes5[simulacaoAposta[i]] == 1){
                valorDaAposta += valorDoJogo5[simulacaoAposta[i]];
                cout<<"O usuario ganhou " + int_to_string(valorDoJogo5[simulacaoAposta[i]])  + " por apostar no " + times[simulacaoAposta[i]][0]<<endl;
            }
            else{
                cout<<"O usuario perdeu 500 reais por apostar no " + times[simulacaoAposta[i]][0]<<endl;
                valorDaAposta -= 500;
            }
        }else{
            break;
        }
    }

    JogosDeCadaTime.push_back(aux);


    exibeResultadoRodada(aux, grupoA, grupoB, "05");

    cout<<"Saldo total do usuario depois dessa rodada: " + int_to_string(valorDaAposta) + "\n\n"<<endl;

    // Rodada 6
    transferencia(times, jogadores, 18);
    aux = "";
    aux2 = "";
    aux3 = "";
    int auxTimes6[10] = {0,0,0,0,0,0,0,0,0,0};
    int valorDoJogo6[10] = {0,0,0,0,0,0,0,0,0,0};

    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 0, 2,getIdTimeGrupo(times, grupoB[0][0]), getIdTimeGrupo(times,grupoA[0][2]), auxTimes6);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 1, 3,getIdTimeGrupo(times, grupoB[0][1]), getIdTimeGrupo(times, grupoA[0][3]),auxTimes6);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoB, grupoA, 2, 4,getIdTimeGrupo(times, grupoB[0][2]),getIdTimeGrupo(times, grupoA[0][4]),auxTimes6);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoB,  grupoA, 3, 0,getIdTimeGrupo(times, grupoB[0][3]), getIdTimeGrupo(times, grupoA[0][0]),auxTimes6);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 4, 1,getIdTimeGrupo(times, grupoB[0][4]), getIdTimeGrupo(times, grupoA[0][1]),auxTimes6);


    aux2 += grupoB[0][0] + "  X  " + grupoA[0][2] + "\n";
    aux2 += grupoB[0][1] + "  X  " + grupoA[0][3] + "\n";
    aux2 += grupoB[0][2] + "  X  " + grupoA[0][4] + "\n";
    aux2 += grupoB[0][3] + "  X  " + grupoA[0][0] + "\n";
    aux2 += grupoB[0][4] + "  X  " + grupoA[0][1] + "\n";


    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][2])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][0])));
    valorDoJogo6[getIdTimeGrupo(times, grupoA[0][2])] = aposta[1];
    valorDoJogo6[getIdTimeGrupo(times, grupoB[0][0])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][0] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][2] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][3])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][1])));
    valorDoJogo6[getIdTimeGrupo(times, grupoA[0][3])] = aposta[1];
    valorDoJogo6[getIdTimeGrupo(times, grupoB[0][1])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][1] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][3] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][4])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][2])));
    valorDoJogo6[getIdTimeGrupo(times, grupoA[0][4])] = aposta[1];
    valorDoJogo6[getIdTimeGrupo(times, grupoB[0][2])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][2] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][4] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][0])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][3])));
    valorDoJogo6[getIdTimeGrupo(times, grupoA[0][0])] = aposta[1];
    valorDoJogo6[getIdTimeGrupo(times, grupoB[0][3])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][3] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][0] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][1])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][4])));
    valorDoJogo6[getIdTimeGrupo(times, grupoA[0][1])] = aposta[1];
    valorDoJogo6[getIdTimeGrupo(times, grupoB[0][4])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][4] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][1] + ": " + int_to_string(aposta[1]) + "\n";


    if(valorDaAposta > 500 && valorDaAposta < 1000){
        valorDaAposta = 1000;
        simulacaoAposta = simulaAposta(times, aux2, aux3, "06");
    }else if(valorDaAposta > 1000){
        simulacaoAposta = simulaAposta(times, aux2, aux3, "06");
    }else{
        valorDaAposta = 1000;
    }

    for(int i = 0; i < 2; i++){
        if( simulacaoAposta[i] != -1){
            if(auxTimes6[simulacaoAposta[i]] == 1){
                valorDaAposta += valorDoJogo6[simulacaoAposta[i]];
                cout<<"O usuario ganhou " + int_to_string(valorDoJogo6[simulacaoAposta[i]])  + " por apostar no " + times[simulacaoAposta[i]][0]<<endl;
            }
            else{
                cout<<"O usuario perdeu 500 reais por apostar no " + times[simulacaoAposta[i]][0]<<endl;
                valorDaAposta -= 500;
            }
        }else{
            break;
        }
    }

    JogosDeCadaTime.push_back(aux);


    exibeResultadoRodada(aux, grupoA, grupoB, "06");

    cout<<"Saldo total do usuario depois dessa rodada: " + int_to_string(valorDaAposta) + "\n\n"<<endl;

    // Rodada 7
    aux = "";
    aux2 = "";
    aux3 = "";
    int auxTimes7[10] = {0,0,0,0,0,0,0,0,0,0};
    int valorDoJogo7[10] = {0,0,0,0,0,0,0,0,0,0};


    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 0, 0,getIdTimeGrupo(times, grupoB[0][0]), getIdTimeGrupo(times,grupoA[0][0]), auxTimes7);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 1, 1,getIdTimeGrupo(times, grupoB[0][1]), getIdTimeGrupo(times, grupoA[0][1]),auxTimes7);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoB, grupoA, 2, 2,getIdTimeGrupo(times, grupoB[0][2]),getIdTimeGrupo(times, grupoA[0][2]),auxTimes7);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoB,  grupoA, 3, 3,getIdTimeGrupo(times, grupoB[0][3]), getIdTimeGrupo(times, grupoA[0][3]),auxTimes7);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 4, 4,getIdTimeGrupo(times, grupoB[0][4]), getIdTimeGrupo(times, grupoA[0][4]),auxTimes7);

    aux2 += grupoB[0][0] + "  X  " + grupoA[0][0] + "\n";
    aux2 += grupoB[0][1] + "  X  " + grupoA[0][1] + "\n";
    aux2 += grupoB[0][2] + "  X  " + grupoA[0][2] + "\n";
    aux2 += grupoB[0][3] + "  X  " + grupoA[0][3] + "\n";
    aux2 += grupoB[0][4] + "  X  " + grupoA[0][4] + "\n";

    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][0])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][0])));
    valorDoJogo7[getIdTimeGrupo(times, grupoA[0][0])] = aposta[1];
    valorDoJogo7[getIdTimeGrupo(times, grupoB[0][0])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][0] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][0] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][1])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][1])));
    valorDoJogo7[getIdTimeGrupo(times, grupoA[0][1])] = aposta[1];
    valorDoJogo7[getIdTimeGrupo(times, grupoB[0][1])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][1] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][1] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][2])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][2])));
    valorDoJogo7[getIdTimeGrupo(times, grupoA[0][2])] = aposta[1];
    valorDoJogo7[getIdTimeGrupo(times, grupoB[0][2])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][2] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][2] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][3])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][3])));
    valorDoJogo7[getIdTimeGrupo(times, grupoA[0][3])] = aposta[1];
    valorDoJogo7[getIdTimeGrupo(times, grupoB[0][3])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][3] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][3] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][4])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][4])));
    valorDoJogo7[getIdTimeGrupo(times, grupoA[0][4])] = aposta[1];
    valorDoJogo7[getIdTimeGrupo(times, grupoB[0][4])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][4] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][4] + ": " + int_to_string(aposta[1]) + "\n";


    if(valorDaAposta > 500 && valorDaAposta < 1000){
        valorDaAposta = 1000;
        simulacaoAposta = simulaAposta(times, aux2, aux3, "07");
    }else if(valorDaAposta > 1000){
        simulacaoAposta = simulaAposta(times, aux2, aux3, "07");
    }else{
        valorDaAposta = 1000;
    }


    for(int i = 0; i < 2; i++){
        if( simulacaoAposta[i] != -1){
            if(auxTimes7[simulacaoAposta[i]] == 1){
                valorDaAposta += valorDoJogo7[simulacaoAposta[i]];
                cout<<"O usuario ganhou " + int_to_string(valorDoJogo7[simulacaoAposta[i]])  + " por apostar no " + times[simulacaoAposta[i]][0]<<endl;
            }
            else{
                cout<<"O usuario perdeu 500 reais por apostar no " + times[simulacaoAposta[i]][0]<<endl;
                valorDaAposta -= 500;
            }
        }else{
            break;
        }
    }

    JogosDeCadaTime.push_back(aux);

    exibeResultadoRodada(aux, grupoA, grupoB, "07");

    cout<<"Saldo total do usuario depois dessa rodada: " + int_to_string(valorDaAposta) + "\n\n"<<endl;


    // Rodada 8
    aux = "";
    aux2 = "";
    aux3 = "";
    int auxTimes8[10] = {0,0,0,0,0,0,0,0,0,0};
    int valorDoJogo8[10] = {0,0,0,0,0,0,0,0,0,0};

    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 0, 1,getIdTimeGrupo(times, grupoB[0][0]), getIdTimeGrupo(times,grupoA[0][1]), auxTimes8);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 1, 2,getIdTimeGrupo(times, grupoB[0][1]), getIdTimeGrupo(times, grupoA[0][2]),auxTimes8);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoB, grupoA, 2, 3,getIdTimeGrupo(times, grupoB[0][2]),getIdTimeGrupo(times, grupoA[0][3]),auxTimes8);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoB,  grupoA, 3, 4,getIdTimeGrupo(times, grupoB[0][3]), getIdTimeGrupo(times, grupoA[0][4]),auxTimes8);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 4, 0,getIdTimeGrupo(times, grupoB[0][4]), getIdTimeGrupo(times, grupoA[0][0]),auxTimes8);

    aux2 += grupoB[0][0] + "  X  " + grupoA[0][1] + "\n";
    aux2 += grupoB[0][1] + "  X  " + grupoA[0][2] + "\n";
    aux2 += grupoB[0][2] + "  X  " + grupoA[0][3] + "\n";
    aux2 += grupoB[0][3] + "  X  " + grupoA[0][4] + "\n";
    aux2 += grupoB[0][4] + "  X  " + grupoA[0][0] + "\n";

    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][1])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][0])));
    valorDoJogo8[getIdTimeGrupo(times, grupoA[0][1])] = aposta[1];
    valorDoJogo8[getIdTimeGrupo(times, grupoB[0][0])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][0] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][1] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][2])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][1])));
    valorDoJogo8[getIdTimeGrupo(times, grupoA[0][2])] = aposta[1];
    valorDoJogo8[getIdTimeGrupo(times, grupoB[0][1])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][1] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][2] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][3])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][2])));
    valorDoJogo8[getIdTimeGrupo(times, grupoA[0][3])] = aposta[1];
    valorDoJogo8[getIdTimeGrupo(times, grupoB[0][2])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][2] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][3] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][4])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][3])));
    valorDoJogo8[getIdTimeGrupo(times, grupoA[0][4])] = aposta[1];
    valorDoJogo8[getIdTimeGrupo(times, grupoB[0][3])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][3] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][4] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][0])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][4])));
    valorDoJogo8[getIdTimeGrupo(times, grupoA[0][0])] = aposta[1];
    valorDoJogo8[getIdTimeGrupo(times, grupoB[0][4])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][4] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][0] + ": " + int_to_string(aposta[1]) + "\n";


    if(valorDaAposta > 500 && valorDaAposta < 1000){
        valorDaAposta = 1000;
        simulacaoAposta = simulaAposta(times, aux2, aux3, "08");
    }else if(valorDaAposta > 1000){
        simulacaoAposta = simulaAposta(times, aux2, aux3, "08");
    }else{
        valorDaAposta = 1000;
    }

    for(int i = 0; i < 2; i++){
        if( simulacaoAposta[i] != -1){
            if(auxTimes8[simulacaoAposta[i]] == 1){
                valorDaAposta += valorDoJogo8[simulacaoAposta[i]];
                cout<<"O usuario ganhou " + int_to_string(valorDoJogo8[simulacaoAposta[i]])  + " por apostar no " + times[simulacaoAposta[i]][0]<<endl;
            }
            else{
                cout<<"O usuario perdeu 500 reais por apostar no " + times[simulacaoAposta[i]][0]<<endl;
                valorDaAposta -= 500;
            }
        }else{
            break;
        }
    }

    JogosDeCadaTime.push_back(aux);


    exibeResultadoRodada(aux, grupoA, grupoB, "08");

    cout<<"Saldo total do usuario depois dessa rodada: " + int_to_string(valorDaAposta) + "\n\n"<<endl;


    // Rodada 9
    aux = "";
    aux2 = "";
    aux3 = "";
    int auxTimes9[10] = {0,0,0,0,0,0,0,0,0,0};
    int valorDoJogo9[10] = {0,0,0,0,0,0,0,0,0,0};

    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 0, 4,getIdTimeGrupo(times, grupoB[0][0]), getIdTimeGrupo(times,grupoA[0][4]), auxTimes9);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 1, 0,getIdTimeGrupo(times, grupoB[0][1]), getIdTimeGrupo(times, grupoA[0][0]),auxTimes9);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoB, grupoA, 2, 1,getIdTimeGrupo(times, grupoB[0][2]),getIdTimeGrupo(times, grupoA[0][1]),auxTimes9);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoB,  grupoA, 3, 2,getIdTimeGrupo(times, grupoB[0][3]), getIdTimeGrupo(times, grupoA[0][2]),auxTimes9);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 4, 3,getIdTimeGrupo(times, grupoB[0][4]), getIdTimeGrupo(times, grupoA[0][3]),auxTimes9);

    aux2 += grupoB[0][0] + "  X  " + grupoA[0][4] + "\n";
    aux2 += grupoB[0][1] + "  X  " + grupoA[0][0] + "\n";
    aux2 += grupoB[0][2] + "  X  " + grupoA[0][1] + "\n";
    aux2 += grupoB[0][3] + "  X  " + grupoA[0][2] + "\n";
    aux2 += grupoB[0][4] + "  X  " + grupoA[0][3] + "\n";

    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][4])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][0])));
    valorDoJogo9[getIdTimeGrupo(times, grupoA[0][4])] = aposta[1];
    valorDoJogo9[getIdTimeGrupo(times, grupoB[0][0])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][0] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][4] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][0])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][1])));
    valorDoJogo9[getIdTimeGrupo(times, grupoA[0][0])] = aposta[1];
    valorDoJogo9[getIdTimeGrupo(times, grupoB[0][1])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][1] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][0] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][1])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][2])));
    valorDoJogo9[getIdTimeGrupo(times, grupoA[0][1])] = aposta[1];
    valorDoJogo9[getIdTimeGrupo(times, grupoB[0][2])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][2] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][1] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][2])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][3])));
    valorDoJogo9[getIdTimeGrupo(times, grupoA[0][2])] = aposta[1];
    valorDoJogo9[getIdTimeGrupo(times, grupoB[0][3])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][3] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][2] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][3])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][4])));
    valorDoJogo9[getIdTimeGrupo(times, grupoA[0][3])] = aposta[1];
    valorDoJogo9[getIdTimeGrupo(times, grupoB[0][4])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][4] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][3] + ": " + int_to_string(aposta[1]) + "\n";


    if(valorDaAposta > 500 && valorDaAposta < 1000){
        valorDaAposta = 1000;
        simulacaoAposta = simulaAposta(times, aux2, aux3, "09");
    }else if(valorDaAposta > 1000){
        simulacaoAposta = simulaAposta(times, aux2, aux3, "09");
    }else{
        valorDaAposta = 1000;
    }

    for(int i = 0; i < 2; i++){
        if( simulacaoAposta[i] != -1){
            if(auxTimes9[simulacaoAposta[i]] == 1){
                valorDaAposta += valorDoJogo9[simulacaoAposta[i]];
                cout<<"O usuario ganhou " + int_to_string(valorDoJogo9[simulacaoAposta[i]])  +" por apostar no " + times[simulacaoAposta[i]][0]<<endl;
            }
            else{
                cout<<"O usuario perdeu 500 reais por apostar no " + times[simulacaoAposta[i]][0]<<endl;
                valorDaAposta -= 500;
            }
        }else{
            break;
        }
    }

    JogosDeCadaTime.push_back(aux);


    exibeResultadoRodada(aux, grupoA, grupoB, "09");

    cout<<"Saldo total do usuario depois dessa rodada: " + int_to_string(valorDaAposta) + "\n\n"<<endl;


    // Rodada 10
    aux = "";
    aux2 = "";
    aux3 = "";
    int auxTimes10[10] = {0,0,0,0,0,0,0,0,0,0};
    int valorDoJogo10[10] = {0,0,0,0,0,0,0,0,0,0};

    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 0, 3,getIdTimeGrupo(times, grupoB[0][0]), getIdTimeGrupo(times,grupoA[0][3]), auxTimes10);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 1, 4,getIdTimeGrupo(times, grupoB[0][1]), getIdTimeGrupo(times, grupoA[0][4]),auxTimes10);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoB, grupoA, 2, 0,getIdTimeGrupo(times, grupoB[0][2]),getIdTimeGrupo(times, grupoA[0][0]),auxTimes10);
    aux += RealizaRodadasDaFaseDeGrupos( times, grupoB,  grupoA, 3, 1,getIdTimeGrupo(times, grupoB[0][3]), getIdTimeGrupo(times, grupoA[0][1]),auxTimes10);
    aux += RealizaRodadasDaFaseDeGrupos( times,  grupoB,  grupoA, 4, 2,getIdTimeGrupo(times, grupoB[0][4]), getIdTimeGrupo(times, grupoA[0][2]),auxTimes10);

    aux2 += grupoB[0][0] + "  X  " + grupoA[0][3] + "\n";
    aux2 += grupoB[0][1] + "  X  " + grupoA[0][4] + "\n";
    aux2 += grupoB[0][2] + "  X  " + grupoA[0][0] + "\n";
    aux2 += grupoB[0][3] + "  X  " + grupoA[0][1] + "\n";
    aux2 += grupoB[0][4] + "  X  " + grupoA[0][2] + "\n";


    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][3])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][0])));
    valorDoJogo10[getIdTimeGrupo(times, grupoA[0][3])] = aposta[1];
    valorDoJogo10[getIdTimeGrupo(times, grupoB[0][0])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][0] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][3] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][4])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][1])));
    valorDoJogo10[getIdTimeGrupo(times, grupoA[0][4])] = aposta[1];
    valorDoJogo10[getIdTimeGrupo(times, grupoB[0][1])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][1] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][4] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][0])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][2])));
    valorDoJogo10[getIdTimeGrupo(times, grupoA[0][0])] = aposta[1];
    valorDoJogo10[getIdTimeGrupo(times, grupoB[0][2])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][2] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][0] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][1])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][3])));
    valorDoJogo10[getIdTimeGrupo(times, grupoA[0][1])] = aposta[1];
    valorDoJogo10[getIdTimeGrupo(times, grupoB[0][3])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][3] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][1] + ": " + int_to_string(aposta[1]) + "\n";
    aposta = calculoDaAposta(somatorioDasForcas(times, getIdTimeGrupo(times, grupoA[0][2])), somatorioDasForcas(times, getIdTimeGrupo(times, grupoB[0][4])));
    valorDoJogo10[getIdTimeGrupo(times, grupoA[0][2])] = aposta[1];
    valorDoJogo10[getIdTimeGrupo(times, grupoB[0][4])] = aposta[0];
    aux3 += "Lucro por apostar no " + grupoB[0][4] + ": " + int_to_string(aposta[0]) + " -------  " + "Lucro por apostar no " + grupoA[0][2] + ": " + int_to_string(aposta[1]) + "\n";

    if(valorDaAposta > 500 && valorDaAposta < 1000){
        valorDaAposta = 1000;
        simulacaoAposta = simulaAposta(times, aux2, aux3, "10");
    }else if(valorDaAposta > 1000){
        simulacaoAposta = simulaAposta(times, aux2, aux3, "10");
    }else{
        valorDaAposta = 1000;
    }

    for(int i = 0; i < 2; i++){
        if( simulacaoAposta[i] != -1){
            if(auxTimes10[simulacaoAposta[i]] == 1){
                valorDaAposta += valorDoJogo10[simulacaoAposta[i]];
                cout<<"O usuario ganhou " + int_to_string(valorDoJogo10[simulacaoAposta[i]])  + " por apostar no " + times[simulacaoAposta[i]][0]<<endl;
            }
            else{
                cout<<"O usuario perdeu 500 reais por apostar no " + times[simulacaoAposta[i]][0]<<endl;
                valorDaAposta -= 500;
            }
        }else{
            break;
        }
    }

    JogosDeCadaTime.push_back(aux);

    exibeResultadoRodada(aux, grupoA, grupoB, "10");

    cout<<"Saldo total do usuario depois dessa rodada: " + int_to_string(valorDaAposta) + "\n\n"<<endl;


    return JogosDeCadaTime;
}




int main() {

    srand((unsigned)time(NULL));
    setlocale(LC_ALL,"");

	//Array com atributos dos times
	string timesAtributos [10][7];

	//Souza:
	timesAtributos[0][0] = "Souza";
	//ataque
	timesAtributos[0][1] = "63";//0 a 100
	//defesa
	timesAtributos[0][2] = "65";//0 a 100
	//controle de jogo
	timesAtributos[0][3] = "65";//0 a 100
	//confian�a
	timesAtributos[0][4] = "68";//100 a 0
	//disposi��o fisica
	timesAtributos[0][5] = "100";//100 a 0
	//torcida
	timesAtributos[0][6] = "80";


	//CSP:
	timesAtributos[1][0] = "CSP";
	//ataque
	timesAtributos[1][1] = "64";//0 a 100
	//defesa
	timesAtributos[1][2] = "66";//0 a 100
	//controle de jogo
	timesAtributos[1][3] = "69";//0 a 100
	//confian�a
	timesAtributos[1][4] = "65";//100 a 0
	//disposi��o fisica
	timesAtributos[1][5] = "100";//100 a 0
	//torcida
	timesAtributos[1][6] = "80";




	//Campinense:
	timesAtributos[2][0] = "Campinense";
	//ataque
	timesAtributos[2][1] = "77";//0 a 100
	//defesa
	timesAtributos[2][2] = "72";//0 a 100
	//controle de jogo
	timesAtributos[2][3] = "77";//0 a 100
	//confian�a
	timesAtributos[2][4] = "76";//100 a 0
	//disposi��o fisica
	timesAtributos[2][5] = "100";//100 a 0
	//torcida
	timesAtributos[2][6] = "80";


	//Treze:
	timesAtributos[3][0] = "Treze";
	//ataque
	timesAtributos[3][1] = "73";//0 a 100
	//defesa
	timesAtributos[3][2] = "70";//0 a 100
	//controle de jogo
	timesAtributos[3][3] = "74";//0 a 100
	//confian�a
	timesAtributos[3][4] = "72";//100 a 0
	//disposi��o fisica
	timesAtributos[3][5] = "100";//100 a 0
	//torcida
	timesAtributos[3][6] = "80";


	//Botafogo:
	timesAtributos[4][0] = "Botafogo";
	//ataque
	timesAtributos[4][1] = "80";//0 a 100
	//defesa
	timesAtributos[4][2] = "76";//0 a 100
	//controle de jogo
	timesAtributos[4][3] = "81";//0 a 100
	//confian�a
	timesAtributos[4][4] = "78";//100 a 0
	//disposi��o fisica
	timesAtributos[4][5] = "100";//100 a 0
	//torcida
	timesAtributos[4][6] = "80";


	//Serrano:
	timesAtributos[5][0] = "Serrano";
	//ataque
	timesAtributos[5][1] = "48";//0 a 100
	//defesa
	timesAtributos[5][2] = "50";//0 a 100
	//controle de jogo
	timesAtributos[5][3] = "56";//0 a 100
	//confian�a
	timesAtributos[5][4] = "52";//100 a 0
	//disposi��o fisica
	timesAtributos[5][5] = "100";//100 a 0
	//torcida
	timesAtributos[5][6] = "80";

	//Perilima:
	timesAtributos[6][0] = "Perilima";
	//ataque
	timesAtributos[6][1] = "46";//0 a 100
	//defesa
	timesAtributos[6][2] = "50";//0 a 100
	//controle de jogo
	timesAtributos[6][3] = "59";//0 a 100
	//confian�a
	timesAtributos[6][4] = "46";//100 a 0
	//disposi��o fisica
	timesAtributos[6][5] = "100";//100 a 0
	//torcida
	timesAtributos[6][6] = "80";


	//Atletico - PB:
	timesAtributos[7][0] = "Atletico - PB";
	//ataque
	timesAtributos[7][1] = "58";//0 a 100
	//defesa
	timesAtributos[7][2] = "61";//0 a 100
	//controle de jogo
	timesAtributos[7][3] = "62";//0 a 100
	//confian�a
	timesAtributos[7][4] = "59";//100 a 0
	//disposi��o fisica
	timesAtributos[7][5] = "100";//100 a 0
	//torcida
	timesAtributos[7][6] = "80";



	//Esporte de Patos:
	timesAtributos[8][0] = "Esporte de Patos";
	//ataque
	timesAtributos[8][1] = "57";//0 a 100
	//defesa
	timesAtributos[8][2] = "62";//0 a 100
	//controle de jogo
	timesAtributos[8][3] = "61";//0 a 100
	//confian�a
	timesAtributos[8][4] = "57";//100 a 0
	//disposi��o fisica
	timesAtributos[8][5] = "100";//100 a 0
	//torcida
	timesAtributos[8][6] = "80";



	//Nacional de Patos:
	timesAtributos[9][0] = "Nacional de Patos";
	//ataque
	timesAtributos[9][1] = "59";//0 a 100
	//defesa
	timesAtributos[9][2] = "60";//0 a 100
	//controle de jogo
	timesAtributos[9][3] = "60";//0 a 100
	//confian�a
	timesAtributos[9][4] = "61";//100 a 0
	//disposi��o fisica
	timesAtributos[9][5] = "100";//100 a 0
	//torcida
	timesAtributos[9][6] = "80";




	// 7 Linhas para o time e seus atributos e 2 linhas a quantidade de times
    string Grupo_A[7][5] = {{},  // Time
                            {"0","0","0","0","0"},  // Pontos
                            {"0","0","0","0","0"},  // Partidas
                            {"0","0","0","0","0"},  // Vitorias
                            {"0","0","0","0","0"},  // Empates
                            {"0","0","0","0","0"},  // Derrotas
                            {"0","0","0","0","0"}}; // Gols

    string Grupo_B[7][5] = {{},  // Time
                            {"0","0","0","0","0"},  // Pontos
                            {"0","0","0","0","0"},  // Partidas
                            {"0","0","0","0","0"},  // Vitorias
                            {"0","0","0","0","0"},  // Empates
                            {"0","0","0","0","0"},  // Derrotas
                            {"0","0","0","0","0"}}; // Gols

    string jogadoresParaTransferencia[25][4] = {
                            {"Lopeu","A","10","30000"},
                            {"Chaveirinho","A","8","22000"},
                            {"Warlei","A","8","19000"},
                            {"Cleiton","A","7","16000"},
                            {"Romeu ","M","7","18000"},
                            {"Dedé ","M","8","23000"},
                            {"Leandro ","M","5","8000"},
                            {"Xabala ","M","9","21000"},
                            {"Gilmar ","Z","6","11000"},
                            {"Victor ","Z","7","14000"},
                            {"Fábio ","Z","7","14000"},
                            {"Igor ","Z","8","19000"},
                            {"Richardson","Z","9","25000"},
                            {"Henrique Mattos","Z","9","23000"},
                            {"Neílson","Z","8","18000"},
                            {"Alemão","Z","8","19000"},
                            {"Coradin","Z","9","23000"},
                            {"Lúcio Curió","A","7","16000"},
                            {"Henrique","A","6","12000"},
                            {"Léo Alves","A","7","16000"},
                            {"Klayvert","A","7","15000"},
                            {"Léo Silva","M","7","12000"},
                            {"Leandro","M","8","8000"},
                            {"Geo","M","5","5000"},
                            {"Senega","M","6","9000"}};



    string sorteio = SorteiroFaseDeGrupos(timesAtributos, Grupo_A, Grupo_B);
    cout << sorteio << endl;

    vector<string> jogos = RealizandoOsJogosDaFaseDeGrupos(timesAtributos, Grupo_A, Grupo_B, jogadoresParaTransferencia);


/*
    cout << "---------- Jogos ----------" << endl;
    cout << "Rodada 01\n" + jogos[0] << "\n" << endl;
    cout << "Rodada 02\n" + jogos[1] << "\n" << endl;
    cout << "Rodada 03\n" + jogos[2] << "\n" << endl;
    cout << "Rodada 04\n" + jogos[3] << "\n" << endl;
    cout << "Rodada 05\n" + jogos[4] << endl;
    cout << "Rodada 06\n" + jogos[5] << "\n" << endl;
    cout << "Rodada 07\n" + jogos[6] << "\n" << endl;
    cout << "Rodada 08\n" + jogos[7] << "\n" << endl;
    cout << "Rodada 09\n" + jogos[8] << "\n" << endl;
    cout << "Rodada 10\n" + jogos[9] << endl;
*/
/*
    cout << "---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------" << endl;
    string resul1 = getGrupoOrdenado(Grupo_A, "A");
    string resul2 = getGrupoOrdenado(Grupo_B, "B");
    cout <<  resul1;
    cout << "---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------" << endl;
    cout <<  resul2;

    */


    vector<int> classificados_A = getClassificadosParaFinal(Grupo_A);
    vector<int> classificados_B = getClassificadosParaFinal(Grupo_B);
    cout << "---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------\n\n" << endl;


    cout << "Classificados para semifinal do Grupo A:" << endl;
    cout << Grupo_A[0][classificados_A[0]] << "\n" << Grupo_A[0][classificados_A[1]] << endl;

    cout << endl;

    cout << "Classificados para semifinal do Grupo B:" << endl;
    cout << Grupo_B[0][classificados_B[0]] << "\n" << Grupo_B[0][classificados_B[1]] << endl;

}
