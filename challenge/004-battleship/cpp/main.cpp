using namespace std;

# include "iostream"

class Battleship {
  public:
    static const char SPACE_EMPTY='A';
    static const char SPACE_OCCUPIED='B';
    static const char SPACE_HIT='C';
    static const char SPACE_MISS='D';

    Battleship(string* scheme, int scheme_size, string* target, int target_size);
    void board();
    int hits();
    int sunk();
    int points();
  private:
    int sunkCruiser();
    char* mapCordinate(string coordinate);
    char board_data[5][5];
    void populateBoardData();
};

Battleship::Battleship(string* scheme, int scheme_size, string* target, int target_size){
  populateBoardData();
  for(int i = 0; i < scheme_size; i++){
    *Battleship::mapCordinate(scheme[i]) = SPACE_OCCUPIED;
  }
  for(int i = 0; i < target_size; i++){
    char* cell = Battleship::mapCordinate(target[i]);
    if(*cell == SPACE_OCCUPIED){
      *cell = SPACE_HIT;
    }else{
      *cell = SPACE_MISS;
    }
  }
}

void Battleship::populateBoardData(){
  for(int i = 0; i < 5; i++){
    for(int j = 0; j < 5; j++){  
      board_data[i][j] = SPACE_EMPTY;
    }
  }
}

char* Battleship::mapCordinate(string coordinate){
  if(coordinate.length() != 2){
    cerr << "Invalid coordinate reference \"" << coordinate << "\"" << endl;
    exit(1);
  }

  int ref1;
  switch(coordinate[0]){
    case 'A': ref1 = 0; break;
    case 'B': ref1 = 1; break;
    case 'C': ref1 = 2; break;
    case 'D': ref1 = 3; break;
    case 'E': ref1 = 4; break;
    default: 
      cerr << "Invalid coordinate reference \"" << coordinate << "\"" << endl;
      exit(1);
  }
  int ref2 = atoi(&coordinate[1]);
  if(ref2 < 0 || ref2 > 5){
    cerr << "Invalid coordinate reference \"" << coordinate << "\"" << endl;
    exit(1);
  }
  ref2--;

  return &board_data[ref1][ref2];
}

void Battleship::board(){
  cout << "    1  2  3  4  5 " << endl;
  for(int i = 0; i < 5; i++){
    char reference;
    switch(i){
      case 0: reference = 'A'; break;
      case 1: reference = 'B'; break;
      case 2: reference = 'C'; break;
      case 3: reference = 'D'; break;
      case 4: reference = 'E'; break;
    }    
    cout << " " << reference << " ";
    for(int j = 0; j < 5; j++){
      const char* output;
      switch(board_data[i][j]){
        case SPACE_EMPTY:
          output = u8"\u25cb";
          break;
        case SPACE_OCCUPIED:
          output = u8"\u25cf";
          break;
        case SPACE_MISS:
          output = u8"\u263c";
          break;
        case SPACE_HIT:
          output = u8"\u2600";
          break;
        default: 
          output = "X";
      }
      cout << " " << output << " ";
    }
    cout << endl;
  }
  cout << endl;
}

int Battleship::hits(){
  int count = 0;
  for(int i = 0; i < 5; i++){
    for(int j = 0; j < 5; j++){  
      if(board_data[i][j] == 'C'){
        count++;
      };
    }
  }
  return count;
}

int Battleship::sunk(){
  int count = 0;

  count += sunkCruiser();

  for(int i = 0; i < 5; i++){
    for(int j = 0; j < 5; j++){
      // Detect Patrol
      // Check all surrounding cells to check not a cruiser
      if(board_data[i][j] == SPACE_HIT
          && (j-1 < 0 || (board_data[i][j-1] != SPACE_OCCUPIED && board_data[i][j-1] != SPACE_HIT))
          && (i-1 < 0 || (board_data[i-1][j] != SPACE_OCCUPIED && board_data[i-1][j] != SPACE_HIT))
          && (j+1 > 4 || (board_data[i][j+1] != SPACE_OCCUPIED && board_data[i][j+1] != SPACE_HIT))
          && (i+1 > 4 || (board_data[i+1][j] != SPACE_OCCUPIED && board_data[i+1][j] != SPACE_HIT))
        ){
        count++;
        continue;
      }
    }
  }
  return count;
}

int Battleship::sunkCruiser(){
  int count = 0;
  // Detect Cruiser (only need to look forward, backwards already counted)
  for(int i = 0; i < 5; i++){
    for(int j = 0; j < 5; j++){
      if(board_data[i][j] == SPACE_HIT && 
          (
            (j+1 < 5 && board_data[i][j+1] == SPACE_HIT)
              || (i+1 < 5 && board_data[i+1][j] == SPACE_HIT)
          )
      ){
        count++;
        continue;
      }
    }
  }
  return count;
}

int Battleship::points(){
  return hits() + sunkCruiser() * 2;
}

void loadData(string arg, string* dataset, int size){
  size_t pos;
  string delimiter = ",";
  int count;

  count = 0;
  while ((pos = arg.find(delimiter)) != string::npos && count < size) {
    dataset[count] = arg.substr(0, pos);
    arg.erase(0, pos + delimiter.length());
    count++;
  }
  if(count + 1 <= size){
    dataset[count] = arg;
    count++;
  }
  if(count != size){
    cerr << "Expecting " << size << " entries. Found " << count << endl;
    exit(1);
  }
}

int main (int argc, char *argv[]) {
  if(argc != 5){
    cerr << "Usage: ./main \"<scheme>\" <scheme_size> \"<target>\" <target_size>" << endl;
    exit(1);
  }

  // Load scheme
  string scheme_string = argv[1];
  int scheme_size = atoi(argv[2]);
  string scheme[9];
  loadData(scheme_string, scheme, scheme_size);

  // Load target
  string target_string = argv[3];
  int target_size = atoi(argv[4]);
  string target[6];
  loadData(target_string, target, target_size);

  setlocale(LC_ALL, "");
  Battleship battleship(scheme, scheme_size, target, target_size);
  battleship.board();
  cout << "Hits: " << battleship.hits() << endl;
  cout << "Sunk: " << battleship.sunk() << endl;
  cout << "Points: " << battleship.points() << endl;
  return 0;
}
