<!-- slider section -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- slider section -->
<section class="slider_section">

    <div id="customCarousel1" class="carousel slide" data-ride="carousel" data-interval="3000">

        <div class="carousel-inner">

            <c:forEach var="b" items="${banner}" varStatus="status">
                <div class="item ${status.first ? 'active' : ''}">

                    <div class="hero_area">

                        <!-- IMAGE -->
                        <div class="bg-box">
                            <img src="${pageContext.request.contextPath}/uploads/${b.bannerName}" />
                        </div>

                        <!-- TEXT -->
                       <!--   <div class="container">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="detail-box">
                                        <h1>PooRah Fashion</h1>
                                        <p>New arrivals just dropped </p>
                                        <a href="#" class="btn1">Shop Now</a>
                                    </div>
                                </div>
                            </div>
                        </div>-->

                    </div>

                </div>
            </c:forEach>

        </div>

        <!-- DOTS -->
        <ol class="carousel-indicators">
            <c:forEach var="b" items="${banner}" varStatus="status">
                <li data-target="#customCarousel1"
                    data-slide-to="${status.index}"
                    class="${status.first ? 'active' : ''}">
                </li>
            </c:forEach>
        </ol>

    </div>

</section>
<!-- end slider section -->