<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.cj.protocol.Resultset" %>

<html>
<body>

    <%
        String dbname = "database";
        String admin = "root";
        String pass = "";
        String db_url = "jdbc:mysql://localhost:3306/" + dbname;

        String options = null;

        Connection connection = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(db_url, admin, pass);
            System.out.println("Connection Successful.");
        } catch (Exception e) {
            System.out.println("ERROR: could not connect to database!");
            e.printStackTrace();
        }

        String query = "Select * from beverages";

        assert connection != null;
        Statement statement = null;
        try {
            statement = connection.createStatement();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        ResultSet resultSet = null;
        try {
            resultSet = statement.executeQuery(query);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        while(true){
            try {
                if (!resultSet.next()) break;
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            String dname = null;
            try {
                dname = resultSet.getString("drinkname");
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            int rate = 0;
            try {
                rate = resultSet.getInt("rate");
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            options += "<option value ="+ rate + ">" + dname + " - " + rate + " Rs</option>";
        }

        try {
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    %>
    <label>
        <select>
            <option>Select a Drink</option>
            <%= options %>
        </select>
    </label>
</body>

</html>