/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.filter;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.user.UserDTO;

/**
 *
 * @author huuda
 */
public class AuthenFiler implements Filter {

    private static List<String> USER_RESOURCE;
    private static List<String> ADMIN_RESOURCE;
    private static List<String> NOW_AUTHEN_RESOURCE;
    private static final String US = "US";
    private static final String AD = "AD";
    private static final String LOGIN_PAGE = "home.jsp";

    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public AuthenFiler() {
        USER_RESOURCE = new ArrayList<>();
        USER_RESOURCE.add("user.jsp");
        USER_RESOURCE.add("shop.jsp");
        USER_RESOURCE.add("home.jsp");
        USER_RESOURCE.add("cart.jsp");
        USER_RESOURCE.add("orderConfirmation.jsp");
        USER_RESOURCE.add("sellerPage.jsp");

        ADMIN_RESOURCE = new ArrayList<>();
        ADMIN_RESOURCE.add("admin.jsp");
        ADMIN_RESOURCE.add("user.jsp");
        ADMIN_RESOURCE.add("home.jsp");
        ADMIN_RESOURCE.add("shop.jsp");
        ADMIN_RESOURCE.add("adminProductView.jsp");
        ADMIN_RESOURCE.add("sendEmail.jsp");

        NOW_AUTHEN_RESOURCE = new ArrayList<>();
        NOW_AUTHEN_RESOURCE.add("login.html");
        NOW_AUTHEN_RESOURCE.add("login.jsp");
        NOW_AUTHEN_RESOURCE.add("create.html");
        NOW_AUTHEN_RESOURCE.add("create.jsp");
        NOW_AUTHEN_RESOURCE.add("home.jsp");
        NOW_AUTHEN_RESOURCE.add("aboutUs.jsp");
        NOW_AUTHEN_RESOURCE.add("contact.html");
        
        NOW_AUTHEN_RESOURCE.add("MainController");
        NOW_AUTHEN_RESOURCE.add("GoogleLoginController");
        NOW_AUTHEN_RESOURCE.add("OrderController");
        NOW_AUTHEN_RESOURCE.add("FindProductByCategory");
        NOW_AUTHEN_RESOURCE.add("UploadFileServlet");
        NOW_AUTHEN_RESOURCE.add("UpdateProductController");
        NOW_AUTHEN_RESOURCE.add("RemoveController");
        NOW_AUTHEN_RESOURCE.add("SellerProductController");
        NOW_AUTHEN_RESOURCE.add("DeleteBySeller");
        NOW_AUTHEN_RESOURCE.add("SendEmailController");
        
        NOW_AUTHEN_RESOURCE.add(".css");
        NOW_AUTHEN_RESOURCE.add(".TTF");
        NOW_AUTHEN_RESOURCE.add(".png");
        NOW_AUTHEN_RESOURCE.add(".gif");
        NOW_AUTHEN_RESOURCE.add(".jpg");
        NOW_AUTHEN_RESOURCE.add(".jfif");
        NOW_AUTHEN_RESOURCE.add(".js");
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthenFiler:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthenFiler:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        if (debug) {
            log("AuthenFiler:doFilter()");
        }

        doBeforeProcessing(request, response);

        Throwable problem = null;
        try {
            HttpServletRequest req = (HttpServletRequest) request;
            HttpServletResponse res = (HttpServletResponse) response;
            String url = req.getRequestURI();
            int index = url.lastIndexOf("/");
            String resource = url.substring(index + 1);
            boolean checkContain = false;
            for (String value : NOW_AUTHEN_RESOURCE) {
                if (url.contains(value)) {
                    checkContain = true;
                    break;
                }
            }
            if (checkContain) {
                chain.doFilter(request, response);
            } else {
                HttpSession session = req.getSession();
                if (session == null || session.getAttribute("LOGIN_USER") == null) {
                    res.sendRedirect(LOGIN_PAGE);
                } else {
                    UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
                    String roleID = user.getRoleID();
                    if (AD.equals(roleID) && ADMIN_RESOURCE.contains(resource)) {
                        chain.doFilter(request, response);
                    } else if (US.equals(roleID) && USER_RESOURCE.contains(resource)) {
                        chain.doFilter(request, response);
                    } else {
                        res.sendRedirect(LOGIN_PAGE);
                    }
                }
            }
        } catch (Exception e) {
            // If an exception is thrown somewhere down the filter chain,
            // we still want to execute our after processing, and then
            // rethrow the problem after that.
        }

        doAfterProcessing(request, response);

        // If there was a problem, we want to rethrow it if it is
        // a known type, otherwise log it.
        if (problem != null) {
            if (problem instanceof ServletException) {
                throw (ServletException) problem;
            }
            if (problem instanceof IOException) {
                throw (IOException) problem;
            }
            sendProcessingError(problem, response);
        }
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("AuthenFiler:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("AuthenFiler()");
        }
        StringBuffer sb = new StringBuffer("AuthenFiler(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
