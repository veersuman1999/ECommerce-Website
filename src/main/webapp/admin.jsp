<%@page import="java.util.Map"%>
<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.User"%>
<%@page import ="com.learn.mycart.entities.Category"%>
<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "You are not logged in !! Login first");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "You are not Admin!! Do not access this page");
            response.sendRedirect("login.jsp");
            return;
        }
    }


%>
<%    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> list = cdao.getCategories();
    //getting count
    Map<String,Long> m = Helper.getCounts(FactoryProvider.getFactory());

%>  

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <%@include file="components/common_css_js.jsp" %>

    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container admin">
            <div class="container-fluid mt-3">
                <%@include file="components/message.jsp" %>
            </div>

            <div class="row mt-3">
                <!--first col-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-centre">

                            <div class="container">
                                <img style="max-width: 150px; " class="img-fluid rounded-circle" src="img/user.png" alt=""user_icon">
                            </div>
                            <h1><%=m.get("userCount") %></h1>
                            <h1 class="text-uppercase text-muted">Users</h1>
                        </div>
                    </div> 


                </div>
                <!--second col-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-centre">
                            <div class="container">
                                <img style="max-width: 150px; " class="img-fluid rounded-circle" src="img/list.png" alt=""user_icon">
                            </div>
                            <h1><%=list.size() %></h1>
                            <h1 class="text-uppercase text-muted">Category</h1>
                        </div>
                    </div>  


                </div>
                <!--third col-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-centre">
                            <div class="container">
                                <img style="max-width: 150px; " class="img-fluid rounded-circle" src="img/product.png" alt=""user_icon">
                            </div>
                            <h1><%=m.get("productCount") %></h1>
                            <h1 class="text-uppercase text-muted">Products</h1>
                        </div>
                    </div> 


                </div>
            </div>

            <!--second row-->
            <div class="row mt-3">
                <!--second row first col-->
                <div class="col-md-6">


                    <div class="card" data-toggle="modal" data-target="#add-category-modal">
                        <div class="card-body text-centre">

                            <div class="container">
                                <img style="max-width: 150px; " class="img-fluid rounded-circle" src="img/category.png" alt=""user_icon">
                            </div>
                            <p class="mt-2">Click here to add new Category</p>
                            <h1 class="text-uppercase text-muted">Add Category</h1>
                        </div>
                    </div> 

                </div>



                <!--second row second col-->
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-product-modal">
                        <div class="card-body text-centre">

                            <div class="container">
                                <img style="max-width: 150px; " class="img-fluid rounded-circle" src="img/plus.png" alt=""user_icon">
                            </div>
                            <p class="mt-2">Click here to add Product</p>
                            <h1 class="text-uppercase text-muted">Add Products</h1>
                        </div>
                    </div> 

                </div>
            </div>


        </div>




        <!--add category modal-->



        <!-- Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill Category Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post">

                            <input type="hidden" name="operation" value="addcategory"/>

                            <div class="form-group">
                                <input type="text" class="form-control" name="categoryTitle" placeholder="Enter Category Title" required />

                            </div>

                            <div class="form-group">
                                <textarea style="height: 200px;" class="form-control" placeholder="Enter Category Description" name="categoryDescription" required></textarea>                      
                            </div>

                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Category</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>


                        </form>


                    </div>

                </div>
            </div>
        </div>


        <!--end of category modal-->

        <!--product modal
        <!-- Modal -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">

                            <input type="hidden" name="operation" value="addproduct"/>

                            <!--product title-->

                            <div class="form-group">
                                <input type="text" class="form-control" name="pName" placeholder="Enter Product Title" required />

                            </div>

                            <div class="form-group">
                                <textarea style="height: 100px;" class="form-control" placeholder="Enter Product Description" name="pDesc" required></textarea>                     
                            </div>

                            <div class="form-group">
                                <input type="number" class="form-control" name="pPrice" placeholder="Enter Product Price" required />

                            </div>
                            <div class="form-group">
                                <input type="number" class="form-control" name="pDiscount" placeholder="Enter Product Discount" required />

                            </div>
                            <div class="form-group">
                                <input type="number" class="form-control" name="pQuantity" placeholder="Enter Product Quantity" required />

                            </div>



                            <div class="form-group">
                                <select name="categoryId" class="form-control" id="">
                                    <%                                        for (Category c : list) {

                                    %>    

                                    <option value="<%= c.getCategoryId()%>"><%= c.getCategoryTitle()%></option>
                                    <%
                                        }
                                    %>    

                                </select>

                            </div>

                            <div class="form-group">
                                <label for="pPhoto">Select Picture of Product</label>
                                <br>
                                <input type="file" name="pPhoto" required />
                            </div>



                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Product</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>


                        </form>


                    </div>

                </div>
            </div>
        </div>





        <!--end-->
        <%@include file="components/common_modals.jsp"  %>
    </body>
</html>
