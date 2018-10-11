package mypackage;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

/**
 * Servlet implementation class Process1
 */
public class Process1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Process1() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doPost(request, response);
    }
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		String value = request.getParameter("data");
		System.out.println(value);
		String [] input = value.split(" ");
		int numV = Integer.parseInt(input[0]);
		int [] [] distanceMatrix = new int[numV][numV];
		int i;
		int j;
		int k;
		for (i = 1; i < input.length; i++) {
			for (j = 0; j < numV; j++) {
				for (k = 0; k < numV; k++) {
					distanceMatrix [j][k] = Integer.parseInt(input[i]);
					i++;
					System.out.println(distanceMatrix [j][k]);
				}
			}
			
		}
		TSP tspNearestNeighbour = new TSP();
        String out = tspNearestNeighbour.tsp(distanceMatrix);
        String places = request.getParameter("stoplists");
        
        
        System.out.println(places);
        System.out.println(out);
        
        this.getServletContext().getRequestDispatcher("/Route.jsp").
        include(request, response);
        request.setAttribute("data", out);
        request.setAttribute("stoplists", places);
        String nextJSP = "/Route.jsp";
        
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
        dispatcher.forward(request,response);
        
        getServletConfig().getServletContext().getRequestDispatcher("/Route.jsp").forward(request, response);
	}

}
