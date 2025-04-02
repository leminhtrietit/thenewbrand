<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>MinhTrietEras</title>
        <link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="icon" href="assets/images/logo_tron.png" type="image/x-icon" />

        <link rel="stylesheet" href="assets/css/animate.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="assets/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <link rel="stylesheet" href="assets/css/flaticon.css">
        <link rel="stylesheet" href="assets/css/style_detail.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/2.1.8/css/dataTables.dataTables.css" />

    </head>
    <body>

<!-- Page Wrapper -->
    <div id="wrapper">


        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

        
        <x`!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                 

<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
		<div class="container">
			<a class="navbar-brand" href="{{ route('home') }}">MT<span>solution</span></a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
				<span class="oi oi-menu"></span> Menu
			</button>

			<div class="collapse navbar-collapse" id="ftco-nav">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item active"><a href="{{ route('home') }}" class="nav-link">Home</a></li>
					<!-- <li class="nav-item"><a href="about.html" class="nav-link">About</a></li> -->
					<!-- <li class="nav-item"><a href="index.php?controller=tools" class="nav-link">Tools</a></li> -->
					 <li class="nav-item"><a href="{{ route('resource.index') }}" class="nav-link">Download</a></li>
					 <!-- <li class="nav-item"><a href="login.php" class="nav-link"><img src="assets/images/logo_mau_sv.png" alt="Sao Viet" width="30"></a></li> -->

					<!--<li class="nav-item"><a href="blog.html" class="nav-link">Blog</a></li>
					<li class="nav-item"><a href="contact.html" class="nav-link">Contact us</a></li>
					<li class="nav-item cta"><a href="#" class="nav-link">Free Consultation</a></li> -->

				</ul>
			</div>
		</div>
	</nav>
                <!-- End of Topbar -->
                
                <!-- Begin Page Content -->
                <div class="hero-wrap js-fullheight" style="background-image: url({{ asset((env('APP_ENV') == 'local' ? '' : '') . 'assets/images/bg_1.jpg') }});" data-stellar-background-ratio="0.5">
                    <div class="overlay"></div>
                    <div class="container">
                        <div class="row no-gutters slider-text js-fullheight align-items-center" data-scrollax-parent="true">
                            <div class="col-md-8 ftco-animate mt-5 pt-md-5" data-scrollax=" properties: { translateY: '70%' }">
                                <div class="row">
                                    <div class="col-md-7">
                                        <p class="mb-4 pl-md-5 line" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">tell what you do</p>
                                    </div>
                                </div>
                                <!-- <h1 class="mb-4" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Trải nghiệm từ cuộc sống <br>Mọi thứ về công nghệ</h1> -->
                                <!-- <p><a href="#" class="btn btn-primary px-4 py-3">Read more</a></p> -->
                            </div>
                        </div>
                    </div>
                </div>
                
                
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="ftco-footer ftco-footer-2 ftco-section">
            <div class="container">
                <div class="row mb-5">
                    <div class="col-md">
                        <div class="ftco-footer-widget mb-4">
                            <h2 class="ftco-footer-logo">MT<span>solution</span></h2>
                            <p>
                                All your need!
                            </p>
                            <ul class="ftco-footer-social list-unstyled mt-2">
                                <li class="ftco-animate"><a href="https://x.com/tinhoctanbinh"><span class="fa fa-twitter"></span></a></li>
                                <li class="ftco-animate"><a href="https://www.messenger.com/t/minhtriet.info"><span class="fa fa-facebook"></span></a></li>
                                <!-- <li class="ftco-animate"><a href="#"><span class="fa fa-instagram"></span></a></li> -->
                                <!-- <li class="ftco-animate"><a href="mailto:contact@leminhtriet.com"><span class="bi bi-envelope-fill"></span></a></li> -->
                            
                            </ul>
                        </div>
                    </div>

                    <div class="col-md">
                        <div class="ftco-footer-widget mb-4">
                            <h2 class="ftco-heading-2">Have a Questions?</h2>
                            <div class="block-23 mb-3">
                                <ul>
                                <li><a href="https://maps.app.goo.gl/r1HVi3nZPJc9iqdc8"><span class="icon fa fa-map marker"></span><span class="text">District 7, Ho Chi Minh</span></a></li>
                                <li><a href="tel:+84946426536"><span class="icon fa fa-phone"></span><span class="text">+84 946 426 536</span></a></li>
                                    <li><a href="mailto:contact@leminhtriet.com"><span class="icon fa fa-paper-plane pr-4"></span><span class="text">contact@leminhtriet.com</span></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 text-center">

                        <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | by <a href="https://leminhtriet.com" target="_blank">MinhTrietProduction</a>
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                        </div>
                    </div>
                </div>
            </footer>

            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>







    <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/jquery-migrate-3.0.1.min.js"></script>
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/jquery.easing.1.3.js"></script>
    <script src="assets/js/jquery.waypoints.min.js"></script>
    <script src="assets/js/jquery.stellar.min.js"></script>
    <script src="assets/js/owl.carousel.min.js"></script>
    <script src="assets/js/jquery.magnific-popup.min.js"></script>
    <script src="assets/js/jquery.animateNumber.min.js"></script>
    <script src="assets/js/scrollax.min.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
    <script src="assets/js/google-map.js"></script>
    <script src="assets/js/main.js"></script>


    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.16.0/cdn/themes/light.css" />
    <script type="module" src="https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.16.0/cdn/shoelace-autoloader.js"></script>
    <script src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
    <script>
        let table = new DataTable('#myTable');

    </script>


    </body>
</html>
