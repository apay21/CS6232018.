package postgreConnnect;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;



public class DemoDB {
	public static void main(String[] args) {

		try {
			
			
			// Loads the Postgre driver
			Class.forName("org.postgresql.Driver");
			
			// Connect to the database
			Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/product", "postgres","root");
			
			// For atomicity
			con.setAutoCommit(false);
			
			// For isolation 
			// Changing the current isolation the connection commits the current transaction and begins a new transaction.
			con.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
			
			
			Statement stmt = null;
			try {
				// create statement object
				stmt = con.createStatement();
				//succeeding if and only if all contained operations succeed 
				//this is Atomicity
				
				//Adds depot d1 back to Depot and Stock
				//Consistency d1 needs to be added to depot before inserting into stock
				stmt.executeUpdate("INSERT INTO Depot (dep_id, addr, volume) Values" 
						+ "('d1', 'New Yrok', 9000);");
				stmt.executeUpdate("INSERT INTO Stock (prod_id, dep_id, quantity) Values" 
						+ "('p1', 'd1', 1000)," 
						+ "('p3', 'd1', 3000),"  
						+ "('p2', 'd1', -400);");
				
				
				//Before stock table
				System.out.println("Before Depot Stock");
				System.out.println("");
				PreparedStatement stmt2 = con.prepareStatement("select * from stock");
				
				ResultSet Rs1 = stmt2.executeQuery();
				while(Rs1.next()) {
					System.out.println(Rs1.getString(1)+ " " + Rs1.getString(2)+ " " + Rs1.getString(3));
					
					
				}
				
				System.out.println("");
				System.out.println("--------------------");
				System.out.println("Before Depot Table");
				System.out.println("");
				
				//Before Depot table
				PreparedStatement stmt3 = con.prepareStatement("select * from Depot");
				
				ResultSet Rs2 = stmt3.executeQuery();
				while(Rs2.next()) {
					System.out.println(Rs2.getString(1)+ " " + Rs2.getString(2)+ " " + Rs2.getString(3));
					
					
				}
				
				//deleteds The depot d1 from Depot and Stock
				//Deleting d1 from depot will also delete d1 from stock 
				stmt.executeUpdate("delete from depot where dep_id = 'd1'");
				
				
				
				
				System.out.println("");
				System.out.println("--------------------");
				System.out.println("After Stock Table");
				System.out.println("");
				
				//After stock table
				PreparedStatement stmt4 = con.prepareStatement("select * from Stock");
				
				ResultSet Rs3 = stmt4.executeQuery();
				while(Rs3.next()) {
					System.out.println(Rs3.getString(1)+ " " + Rs3.getString(2)+ " " + Rs3.getString(3));
					
					
				}
				
				
				
				System.out.println("");
				System.out.println("--------------------");
				System.out.println("After Depot Table");
				System.out.println("");
				
				//After Depot table
				PreparedStatement stmt5 = con.prepareStatement("select * from Depot");
				
				ResultSet Rs4 = stmt5.executeQuery();
				while(Rs4.next()) {
					System.out.println(Rs4.getString(1)+ " " + Rs4.getString(2)+ " " + Rs4.getString(3));
					
					
				}
				

			} catch (SQLException e) {
				System.out.println("catch Exception");
				// For atomicity
				//terminates a transaction and returns any values that were modified to their previous values
				con.rollback();
				
				//Closes a prepared statement
				stmt.close();
				//Releases this Connection
				con.close();
				return;
			} // main
			con.commit();
			stmt.close();
			con.close();
			
			
			
			
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
		
	}
}
