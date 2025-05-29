package com.shinhan5goodteam.omok.service;


public class BoardService {
    private int roomId;
    private String user1Id; //흑
    private String user2Id; //백
    private int[][] board; //바둑판
    private int size = 15; //15 15
    private String currentTurn; //현재 차례 아이디

	// 방 생성
    public BoardService(int roomId, String user1Id, String user2Id){
        this.roomId = roomId;
        if (Math.random() > 0.5 ){
            this.user1Id = user1Id;
            this.user2Id = user2Id;
        } else {
            this.user1Id = user2Id;
            this.user2Id = user1Id;
        }
        this.board = new int[15][15];
        this.currentTurn = this.user1Id;
    }

	//보드에 돌 적용
    public boolean placeStone(String userId, int x, int y){
        if ( board[y][x] == 0 && currentTurn.equals(userId) ){
            board[y][x] = userId.equals(user1Id) ? 1 : 2; 
            this.currentTurn = userId.equals(user1Id) ? user2Id : user1Id;

            return true;
        }
        
        return false;
    }

	//보드 출력
    public void print() {
        for (int row = 0; row < size; row++) {
        	System.out.printf("%2d", row);
            for (int col = 0; col < size; col++) {
                System.out.print(" " + board[row][col]);
            }
            System.out.println();
        }
        System.out.print("  ");
        for (int col = 'A'; col <= 'O'; col++) {
            System.out.print(" " + (char)col);
        }
        System.out.println();
    }

    public int[][] getBoard(){
        return board;
    }

    public String getCurrentTurn(){
        return currentTurn;
    }

	//삼삼 판단
    public boolean isThreeThree(String userId, int row, int col) {
		int[] dy = { -1, 1, 0, 0, -1, 1, -1, 1 };
		int[] dx = { 0, 0, -1, 1, -1, 1, 1, -1 }; // dfs
		int y = col;
		int x = row;
		int cnt3 = 0;
        int stone = 0;
        if ( userId.equals(user1Id)){
            stone = 1; // 1 이 흑
			board[y][x] = 1;
        } else {
            return true;
        }
		for (int i = 0; i < 8; i += 2) {
			int cnt = 1;
			while (true) {
				int ny = y + dy[i];
				int nx = x + dx[i];
				if (ny < 0 || nx < 0 || ny >= size || nx >= size || board[ny][nx] == 0) {
					break;
				}
				if ( board[ny][nx] != stone ) {
					cnt = 1;
					break;
				}
				cnt++;
				y = ny;
				x = nx;
			}
			y = col;
			x = row;
			while (true) {
				int ny = y + dy[i + 1];
				int nx = x + dx[i + 1];
				if (ny < 0 || nx < 0 || ny >= size || nx >= size || board[ny][nx] == 0) {
					break;
				}
				if (board[ny][nx] != stone ) {
					cnt = 1;
					break;
				}
				cnt++;
				y = ny;
				x = nx;
			}
			if (cnt == 3) {
				cnt3++;
			}
		}
		board[y][x] = 0;
		if (cnt3 >= 2) {
			return false;
		}
		return true;

	}

	//오목 판단
    public boolean isOmok(String userId, int row, int col) {
		int[] dy = { -1, 1, 0, 0, -1, 1, -1, 1 };
		int[] dx = { 0, 0, -1, 1, -1, 1, 1, -1 };
    	int y = col;
    	int x = row;
        int stone = 0;
        if ( userId.equals(user1Id)){
            stone = 1;
        } else {
            stone = 2;
        }
    	for(int i=0;i<8;i+=2) {
    		int cnt = 1;
			y = col;
    		x = row;
    		while(true) {
    			int ny = y + dy[i];
    			int nx = x + dx[i];
				if (ny < 0 || nx < 0 || ny >= size || nx >= size || board[ny][nx] != stone) {
					break;
				} else {
					cnt++;
				}
    			y = ny;
    			x = nx;
    		}
    		y = col;
    		x = row;
    		while(true) {
    			int ny = y + dy[i+1];
    			int nx = x + dx[i+1];
				if (ny < 0 || nx < 0 || ny >= size || nx >= size || board[ny][nx] != stone) {
					break;
				} else {
					cnt++;
				}
    			y = ny;
    			x = nx;
    		}
			if (cnt == 5) {
    			return true;
    		}
    	}
    	return false;
    	 
    }

	public int getRoomId() {
		return roomId;
	}

	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}

	public String getUser1Id() {
		return user1Id;
	}

	public void setUser1Id(String user1Id) {
		this.user1Id = user1Id;
	}

	public String getUser2Id() {
		return user2Id;
	}

	public void setUser2Id(String user2Id) {
		this.user2Id = user2Id;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public void setBoard(int[][] board) {
		this.board = board;
	}

	public void setCurrentTurn(String currentTurn) {
		this.currentTurn = currentTurn;
	}

}
