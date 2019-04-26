#include<stdlib.h>
#include <iostream>
#include <vector>
#include "FinalSemiFinal.h"
#include <string>
#include <cstdlib>





using namespace std;


int semiFinalA[2][2];
int semiFinalB[2][2];
int finalTabela[2][2];

int timesAtributos [10][6];
int calculoDeForca(int somatorio, int torcida, float porcentagemDaTorcida);
int* resultadoFinal(int time1, int time2);
int somatorioDasForcas(string times[10][7], int idTime);




string Times[3][10] = {{"Campinense","Treze","Botafogo","Souza","Nacional de Patos","Serrano","Atletico-PB","Perilima","Esporte de Patos","CSP" },   // Nome do time
                           {"50"        ,"50"   ,"50"      ,"50"   ,"50"               ,"50"     ,"50"         ,"50"      ,"50"              ,"50"  },   // Ataque
                           {"50"        ,"50"   ,"50"      ,"50"   ,"50"               ,"50"     ,"50"         ,"50"      ,"50"              ,"50"  }};  // Defesa


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



int* getMelhoresClassificados(char grupo){

    //Pega os dois melhores classificados da tabela.
    int *saida = new int[2];
    int firstBest = 0;
    int secondBest = 0;

    if(semiFinalA[1][0] >semiFinalA[1][1]){
        firstBest = 0;
    }
    else{
        firstBest = 1;

    }if(semiFinalB[1][0] > semiFinalB[1][1]){
        secondBest = 0;

    }else{
        firstBest = 1;
    }
    saida[0] = semiFinalA[0][firstBest];
    saida[1] = semiFinalB[0][secondBest];
    return saida;


}


void semiFinal(){
    vector<int> timesA = getClassificadosParaFinal(Grupo_A);
    vector<int> timesB = getClassificadosParaFinal(Grupo_B);

    cout << string_to_int(Grupo_A[0][timesA[0]]) << endl;
    int semiFinalA[2][2] = {{string_to_int(Grupo_A[0][timesA[0]]),string_to_int(Grupo_A[0][timesA[1]])},
                            {   0     ,    0    }};

    int semiFinalB[2][2] = {{string_to_int(Grupo_B[0][timesB[0]]), string_to_int(Grupo_B[0][timesB[1]])},
                            {   0     ,    0    }};
    int *resultado;
    resultado=  new int[2];
    cout <<"\n\n----------SEMIFINAL----------\n\n";
    //Grupo A.
    //Jogos ida e volta
    int* dupla = new int[2];
    dupla[0] = semiFinalA[0][0]; dupla[1] = semiFinalA[0][1];

    cout<< "\nGRUPO A :\n";
    cout<< "Jogo 1( " + Times[0][dupla[0]] + " joga em casa): " + Times[0][dupla[0]] + " vs " + Times[0][dupla[1]]<< endl ;
    resultado = partida(dupla[0], dupla[1], 0);

    semiFinalA[1][0] += resultado[0];
    semiFinalA[1][1] += resultado[1];

    cout<< "Jogo 2( " + Times[0][dupla[1]] + " joga em casa): " + Times[0][dupla[0]] + " vs " + Times[0][dupla[1]]<< endl ;
    resultado = partida(dupla[0], dupla[1], 1);

    semiFinalA[1][0] += resultado[0];
    semiFinalA[1][1] += resultado[1];

    if(semiFinalA[1][0] == semiFinalA[1][1]){
        int *resultadoPenaltis = new int[3];
        resultadoPenaltis = penaltis(dupla[0], dupla[1]);
        cout<<"\n-----------EMPATE-----------\n"<<endl;
        cout<<"----------PENALTIS----------"<<endl;

        cout<< resultadoPenaltis[0] << "  Gols ;"<< Times[0][dupla[0]] << endl;
        cout<< resultadoPenaltis[1] << "  Gols ;"<< Times[0][dupla[1]] << endl;
    }






    //Grupo B.
    //Jogos ida e volta
    //  int *dupla2 = new int[2];
    cout<< "\nGRUPO B :\n";
    int* dupla2 = new int[2];
    dupla[0] = semiFinalB[0][1]; dupla[1] = semiFinalB[0][1];

    cout<<"Jogo 1( " + Times[0][dupla[0]] +  " joga em casa): " + Times[0][dupla[0]] + " vs " + Times[0][dupla[1]]<< endl ;
    resultado = partida(dupla[0], dupla[1],0);

    semiFinalB[1][0] += resultado[0];
    semiFinalB[1][1] += resultado[1];

    cout<<"Jogo 2( " + Times[0][dupla[1]] +  " joga em casa): " + Times[0][dupla[0]] + " vs " + Times[0][dupla[1]]<< endl ;
    resultado = partida(dupla[0], dupla[1],1);

    semiFinalB[1][0] += resultado[0];
    semiFinalB[1][1] += resultado[1];

    if(semiFinalB[1][0] == semiFinalB[1][1]){
        int *resultdado = new int[3];
        resultado = penaltis(dupla[0], dupla[1]);
        cout<<"\n-----------EMPATE-----------\n"<<endl;
        cout<<"----------PENALTIS----------"<<endl;

        cout<< resultado[0] << "  Gols ;"<< Times[0][dupla[0]] << endl;
        cout<< resultado[1] << "  Gols ;"<< Times[0][dupla[1]] << endl;
    }


}


void finalCampeonato(){
    int* classificadosFinal  = getMelhoresClassificados('f');
    finalTabela[0][0] = classificadosFinal[0];
    finalTabela[0][1] = classificadosFinal[1];

    cout <<"\n\n----------FINAL----------\n\n";

    int *dupla = new int[2];
    dupla[0] = finalTabela[0][0];
    dupla[1] = finalTabela[0][1];

    cout<< "Jogo 1(Time: " << Times[0][dupla[0]] << " joga em casa): " << Times[0][dupla[0]] << " vs " << Times[0][dupla[0]]<< endl ;
    int *resultado = new int[2];
    resultado = partida(dupla[0], dupla[1], 0);
    finalTabela[1][0] += resultado[0];finalTabela[1][1] += resultado[1];


    cout<<"Jogo 2(Time: " + Times[0][dupla[1]] +  " joga em casa): " + Times[0][dupla[0]] + " vs " + Times[0][dupla[0]]<< endl ;
    resultado = partida(dupla[0], dupla[1],1);
    finalTabela[1][0] += resultado[0];finalTabela[1][1] += resultado[1];


    if(finalTabela[1][0] > finalTabela[1][1]){
        cout << " VENCEDOR DO CAMPEONATO :" << endl;
        cout << "--------" << Times[0][finalTabela[0][0]] << "--------";
    }else if(finalTabela[1][0] < finalTabela[1][1]){
        cout << " VENCEDOR DO CAMPEONATO :" << endl;
        cout << "--------" << Times[0][finalTabela[0][1]] << "--------";

    }else{
        int *resultado = new int[3];
        resultado = penaltis(dupla[0], dupla[1]);
        cout<<"-----------EMPATE-----------"<<endl;
        cout<<"----------PENALTIS----------"<<endl;
        cout << " VENCEDOR DO CAMPEONATO :" << endl;
        cout << "--------" << Times[0][finalTabela[0][resultado[2]]] << "--------";


    }




}


int* penaltis(int time1, int time2){


    int maior = 150;
    int menor = 0;
    int nPenaltis = 0;
    srand((unsigned)time(0)); //para gerar números aleatórios reais.
    int chancesTime1 = timesAtributos[time1][0] +  timesAtributos[time1][1];
    int chancesTime2 = timesAtributos[time2][0] +  timesAtributos[time2][1];
    int pontos1 = 0;
    int pontos2 = 0;
    int vencedor = 0;

    while(pontos1 == pontos2 || nPenaltis <= 10){
        int aleatorio = rand()%(maior-menor+1) + menor;
        int aleatorio1 = rand()%(1-0+1) + 0;
        int aleatorio2 = rand()%(1-0+1) + 0;

        nPenaltis ++;
        if(chancesTime1 >= aleatorio && aleatorio1 == 1 ){
            pontos1 ++;
        }if(chancesTime2 >= aleatorio && aleatorio2 == 1){
            pontos2 ++;
        }
    }
    if(pontos1 > pontos2){
        vencedor = time1;
    }else{
        vencedor = time2;
    }

    int *saida = new int[3];
    saida[0] = pontos1;saida[1] = pontos2; saida[2] = vencedor;
    return saida;


}

int* partida(int time1, int time2,int timeJogaEmCasa){
////Deve ser responsavel por fazer os jjogos, alterar os dados de pontos e exibir isso na tela.
    int resultado1 = somatorioDasForcas(timesAtributos, time1);
    int resultado2 = somatorioDasForcas(timesAtributos, time1);

    int forcaTime1 = 0;
    int forcaTime2 = 0;




    if(timeJogaEmCasa == 0){
        forcaTime1 = calculoDeForca(resultado1, timesAtributos[time1][5], 0.7);
        forcaTime2 = calculoDeForca(resultado1, timesAtributos[time2][5], 0.3);
    }else{
        forcaTime1 = calculoDeForca(resultado1, timesAtributos[time1][5], 0.3);
        forcaTime2 = calculoDeForca(resultado1, timesAtributos[time2][5], 0.7);

    }
    int *resultJogo = new int[2];
    resultJogo = resultadoFinal(forcaTime1, forcaTime2);

    cout<< "----------Resultado Partida----------" << endl;
    cout<< "----- " + Times[0][time1] + " vs " +  Times[0][time1] + " -----" << endl;
    cout<< "      " << resultJogo[0]  <<"    " << resultJogo[1] << endl;

    int *saida = new int[2];
    saida[0]= resultJogo[0];
    saida[1]= resultJogo[1];
    return saida;

}

int calculoDeForca(int somatorio, int torcida, float porcentagemDaTorcida){

    // equivale a 70% da for�a do time
	somatorio = (int) (somatorio * 0.7);

	//a porcentagem da torcida � passada como parametro
	torcida = torcida * porcentagemDaTorcida;

	//retorna a for�a total do time
	return somatorio + torcida;
}

int* resultadoFinal(int time1, int time2){

    srand((unsigned) time(NULL));


    //condi��o para caso um time seja 4 vezes superior ao outro, para que haja chances de acontecer zebras
	if(time1 > 4 * time2){
		time2 = time2 + (rand()% (time1 - time2 + 30));
	}if (time2 > 4 * time1){
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
	int *result = (int*)malloc(2*sizeof(int));
	result[0] = auxTime1;
	result[1] = auxTime2;
    return result;
}


int main()
{

    srand((unsigned)time(NULL));
    setlocale(LC_ALL,"");

    // Estrutura resuzida apenas para testes


    string sorteio = SorteiroFaseDeGrupos(Times, Grupo_A, Grupo_B);
    vector<string> jogos = RealizandoOsJogosDaFaseDeGrupos(Times, Grupo_A, Grupo_B);

    cout << sorteio << endl;

    cout << "---------- Jogos Grupo A ----------" << endl;
    cout << "Rodada 01\n" + jogos[0] << "\n" << endl;
    cout << "Rodada 02\n" + jogos[1] << "\n" << endl;
    cout << "Rodada 03\n" + jogos[2] << "\n" << endl;
    cout << "Rodada 04\n" + jogos[3] << "\n" << endl;
    cout << "Rodada 05\n" + jogos[4] << endl;

    cout << "---------- Jogos Grupo B ----------" << endl;
    cout << "Rodada 06\n" + jogos[5] << "\n" << endl;
    cout << "Rodada 07\n" + jogos[6] << "\n" << endl;
    cout << "Rodada 08\n" + jogos[7] << "\n" << endl;
    cout << "Rodada 09\n" + jogos[8] << "\n" << endl;
    cout << "Rodada 10\n" + jogos[9] << endl;

    cout << "---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------" << endl;
    string resul1 = getGrupoOrdenado(Grupo_A, "A");
    string resul2 = getGrupoOrdenado(Grupo_B, "B");
    cout <<  resul1;
    cout << "---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------" << endl;
    cout <<  resul2;

    vector<int> classificados_A = getClassificadosParaFinal(Grupo_A);
    vector<int> classificados_B = getClassificadosParaFinal(Grupo_B);
    cout << "---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------\n\n" << endl;

    cout << "Classificados para semifinal do Grupo A:" << endl;
    cout << Grupo_A[0][classificados_A[0]] << "\n" << Grupo_A[0][classificados_A[1]] << endl;

    cout << endl;

    cout << "Classificados para semifinal do Grupo B:" << endl;
    cout << Grupo_B[0][classificados_B[0]] << "\n" << Grupo_B[0][classificados_B[1]] << endl;

    //Array com atributos dos times


	//Souza:
	//ataque
	timesAtributos[0][0] = 63;//0 a 100
	//defesa
	timesAtributos[0][1] = 65;//0 a 100
	//controle de jogo
	timesAtributos[0][2] = 65;//0 a 100
	//confian�a
	timesAtributos[0][3] = 68;//100 a 0
	//disposi��o fisica
	timesAtributos[0][4] = 100;//100 a 0
	//torcida
	timesAtributos[0][5] = 80;
	//jogador1
	//timesAtributos[0][5] = 4;//1 a 10
	//jogador2
	//timesAtributos[0][6] = 5;//1 a 10
	//jogador3
	//timesAtributos[0][7] = 5;//1 a 10
	//Capital
	//timesAtributos[0][8] = 5000;

	//CSP:
	//ataque
	timesAtributos[1][0] = 64;//0 a 100
	//defesa
	timesAtributos[1][1] = 66;//0 a 100
	//controle de jogo
	timesAtributos[1][2] = 69;//0 a 100
	//confian�a
	timesAtributos[1][3] = 65;//100 a 0
	//disposi��o fisica
	timesAtributos[1][4] = 100;//100 a 0
	//torcida
	timesAtributos[1][5] = 80;
	//jogador1
	//timesAtributos[0][5] = 4;//1 a 10
	//jogador2
	//timesAtributos[0][6] = 5;//1 a 10
	//jogador3
	//timesAtributos[0][7] = 5;//1 a 10
	//Capital
	//timesAtributos[0][8] = 5000;



	//Campinense:
	//ataque
	timesAtributos[2][0] = 77;//0 a 100
	//defesa
	timesAtributos[2][1] = 72;//0 a 100
	//controle de jogo
	timesAtributos[2][2] = 77;//0 a 100
	//confian�a
	timesAtributos[2][3] = 76;//100 a 0
	//disposi��o fisica
	timesAtributos[2][4] = 100;//100 a 0
	//torcida
	timesAtributos[2][5] = 80;
	//jogador1
	//timesAtributos[0][5] = 4;//1 a 10
	//jogador2
	//timesAtributos[0][6] = 5;//1 a 10
	//jogador3
	//timesAtributos[0][7] = 5;//1 a 10
	//Capital
	//timesAtributos[0][8] = 5000;

	//Treze:
	//ataque
	timesAtributos[3][0] = 73;//0 a 100
	//defesa
	timesAtributos[3][1] = 70;//0 a 100
	//controle de jogo
	timesAtributos[3][2] = 74;//0 a 100
	//confian�a
	timesAtributos[3][3] = 72;//100 a 0
	//disposi��o fisica
	timesAtributos[3][4] = 100;//100 a 0
	//torcida
	timesAtributos[3][5] = 80;
	// //jogador1
	// timesAtributos[1][5] = 4;//1 a 10
	// //jogador2
	// timesAtributos[1][6] = 5;//1 a 10
	// //jogador3
	// timesAtributos[1][7] = 5;//1 a 10

	//Botafogo:
	//ataque
	timesAtributos[4][0] = 80;//0 a 100
	//defesa
	timesAtributos[4][1] = 76;//0 a 100
	//controle de jogo
	timesAtributos[4][2] = 81;//0 a 100
	//confian�a
	timesAtributos[4][3] = 78;//100 a 0
	//disposi��o fisica
	timesAtributos[4][4] = 100;//100 a 0
	//torcida
	timesAtributos[4][5] = 80;
	// //jogador1
	// timesAtributos[2][5] = 4;//1 a 10
	// //jogador2
	// timesAtributos[2][6] = 5;//1 a 10
	// //jogador3
	// timesAtributos[2][7] = 5;//1 a 10

	//Serrano:
	//ataque
	timesAtributos[5][0] = 48;//0 a 100
	//defesa
	timesAtributos[5][1] = 50;//0 a 100
	//controle de jogo
	timesAtributos[5][2] = 56;//0 a 100
	//confian�a
	timesAtributos[5][3] = 52;//100 a 0
	//disposi��o fisica
	timesAtributos[5][4] = 100;//100 a 0
	//torcida
	timesAtributos[5][5] = 80;
	//jogador1
	// timesAtributos[2][5] = 4;//1 a 10
	// //jogador2
	// timesAtributos[2][6] = 5;//1 a 10
	// //jogador3
	// timesAtributos[2][7] = 5;//1 a 10

	//Perilima:
	//ataque
	timesAtributos[6][0] = 46;//0 a 100
	//defesa
	timesAtributos[6][1] = 50;//0 a 100
	//controle de jogo
	timesAtributos[6][2] = 59;//0 a 100
	//confian�a
	timesAtributos[6][3] = 46;//100 a 0
	//disposi��o fisica
	timesAtributos[6][4] = 100;//100 a 0
	//torcida
	timesAtributos[6][5] = 80;
	//jogador1
	// timesAtributos[2][5] = 4;//1 a 10
	// //jogador2
	// timesAtributos[2][6] = 5;//1 a 10
	// //jogador3
	// timesAtributos[2][7] = 5;//1 a 10

	//Atletico - PB:
	//ataque
	timesAtributos[7][0] = 58;//0 a 100
	//defesa
	timesAtributos[7][1] = 61;//0 a 100
	//controle de jogo
	timesAtributos[7][2] = 62;//0 a 100
	//confian�a
	timesAtributos[7][3] = 59;//100 a 0
	//disposi��o fisica
	timesAtributos[7][4] = 100;//100 a 0
	//torcida
	timesAtributos[7][5] = 80;
	//jogador1
	// timesAtributos[2][5] = 4;//1 a 10
	// //jogador2
	// timesAtributos[2][6] = 5;//1 a 10
	// //jogador3
	// timesAtributos[2][7] = 5;//1 a 10


	//Esporte de Patos:
	//ataque
	timesAtributos[8][0] = 57;//0 a 100
	//defesa
	timesAtributos[8][1] = 62;//0 a 100
	//controle de jogo
	timesAtributos[8][2] = 61;//0 a 100
	//confian�a
	timesAtributos[8][3] = 57;//100 a 0
	//disposi��o fisica
	timesAtributos[8][4] = 100;//100 a 0
	//torcida
	timesAtributos[8][5] = 80;
	//jogador1
	// timesAtributos[2][5] = 4;//1 a 10
	// //jogador2
	// timesAtributos[2][6] = 5;//1 a 10
	// //jogador3
	// timesAtributos[2][7] = 5;//1 a 10


	//Nacional de Patos:
	//ataque
	timesAtributos[9][0] = 59;//0 a 100
	//defesa
	timesAtributos[9][1] = 60;//0 a 100
	//controle de jogo
	timesAtributos[9][2] = 60;//0 a 100
	//confian�a
	timesAtributos[9][3] = 61;//100 a 0
	//disposi��o fisica
	timesAtributos[9][4] = 100;//100 a 0
	//torcida
	timesAtributos[9][5] = 80;
	//jogador1
	// timesAtributos[2][5] = 4;//1 a 10
	// //jogador2
	// timesAtributos[2][6] = 5;//1 a 10
	// //jogador3
	// timesAtributos[2][7] = 5;//1 a 10
    semiFinal();
    finalCampeonato();

    return 0;
}




