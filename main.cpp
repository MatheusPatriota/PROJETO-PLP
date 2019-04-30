#include <iostream>
#include <stdio.h>
#include <unistd.h>
#include "CalculoDeForca.hpp"
#include "FinalSemiFinal.hpp"
using namespace std;


int main() {
  char opcao;
  int aposta;
  cout << "Desjesa aumentar o capital de Aposta? " << endl;
  cin >> opcao;
  if (opcao  == 'S')
  {
    cin >> aposta;
    setAposta(aposta);
  }
  
  srand((unsigned)time(NULL));
  setlocale(LC_ALL,"");

  string sorteio = SorteiroFaseDeGrupos(timesAtributos, Grupo_A, Grupo_B);
  cout << sorteio << endl;

  sleep(3);
  system("clear");
  
  vector<string> jogos = RealizandoOsJogosDaFaseDeGrupos(timesAtributos, Grupo_A, Grupo_B, jogadoresParaTransferencia);


 sleep(7);



  vector<int> classificados_A = getClassificadosParaFinal(Grupo_A);
  vector<int> classificados_B = getClassificadosParaFinal(Grupo_B);
  cout << "---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------\n\n" << endl;

 sleep(7);

 
  cout << "Classificados para semifinal do Grupo A:" << endl;
  cout << Grupo_A[0][classificados_A[0]] << "\n" << Grupo_A[0][classificados_A[1]] << endl;

  cout << endl;

  cout << "Classificados para semifinal do Grupo B:" << endl;
  cout << Grupo_B[0][classificados_B[0]] << "\n" << Grupo_B[0][classificados_B[1]] << endl;
  
  sleep(7);
 
  
  semiFinal();

  sleep(7);
 
  
  finalCampeonato();

  cout<< "\n Saldo final do apostador: " << getAposta() <<endl;

  sleep(7);
  

}