package com.shinhan5goodteam.omok.service;

public class BoardService {
    private int roomId;
    private String user1Id; //흑
    private String user2Id; //백
    private int[][] board; //바둑판
    private int size = 15; //15 15
    private String currentTurn; //현재 차례 아이디

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
        this.currentTurn = user1Id;
    }

    public boolean placeStone(String userId, int x, int y){
        if ( board[x][y] == 0 && currentTurn.equals(userId) ){
            board[x][y] = userId.equals(user1Id) ? 1 : 2; 
            currentTurn = userId.equals(user1Id) ? user2Id : user1Id;

            return true;
        }
        
        return false;
    }

    public void print() {
        for (int row = 0; row < size; row++) {
        	System.out.printf("%2d", row);
            for (int col = 0; col < size; col++) {
                System.out.print(" " + board[row][col]);
            }
            System.out.println();
        }
        System.out.print("  ");
        for (int col = 'A'; col <= 'S'; col++) {
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

    public boolean isThreeThree(String userId, int row, int col) {
		int[] dy = { -1, 1, 0, 0, -1, 1, -1, 1 };
		int[] dx = { 0, 0, -1, 1, -1, 1, 1, -1 }; // dfs
		int y = row;
		int x = col;
		int cnt3 = 0;
        int stone = 0;
        if ( userId.equals(user1Id)){
            stone = 1; // 1 이 흑
        } else {
            stone = 2; // 2 가 백
        }
		for (int i = 0; i < 8; i += 2) {
			int cnt = 1;
			while (true) {
				int ny = y + dy[i];
				int nx = x + dx[i];
				if (ny < 0 || nx < 0 || ny >= size || nx >= size || getBoard()[ny][nx] == 0) {
					break;
				}
				if ( getBoard()[ny][nx] != stone ) {
					cnt = 1;
					break;
				}
				cnt++;
				y = ny;
				x = nx;
			}
			y = row;
			x = col;
			while (true) {
				int ny = y + dy[i + 1];
				int nx = x + dx[i + 1];
				if (ny < 0 || nx < 0 || ny >= size || nx >= size || getBoard()[ny][nx] == 0) {
					break;
				}
				if ( getBoard()[ny][nx] != stone ) {
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
		if (cnt3 >= 2) {
			return false;
		}
		return true;

	}

    public boolean isOmok(String userId, int row, int col) {
		int[] dy = { -1, 1, 0, 0, -1, 1, -1, 1 };
		int[] dx = { 0, 0, -1, 1, -1, 1, 1, -1 };
    	int y = row;
    	int x = col;
        int stone = 0;
        if ( userId.equals(user1Id)){
            stone = 1;
        } else {
            stone = 2;
        }
    	for(int i=0;i<8;i+=2) {
    		int cnt = 1;
    		while(true) {
    			int ny = y + dy[i];
    			int nx = x + dx[i];
				if (ny < 0 || nx < 0 || ny >= size || nx >= size || getBoard()[ny][nx] != stone
						|| getBoard()[ny][nx] != 0) {
					break;
				} else {
					cnt++;
				}
    			y = ny;
    			x = nx;
    		}
    		y = row;
    		x = col;
    		while(true) {
    			int ny = y + dy[i+1];
    			int nx = x + dx[i+1];
				if (ny < 0 || nx < 0 || ny >= size || nx >= size || getBoard()[ny][nx] != stone
						|| getBoard()[ny][nx] != 0) {
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
