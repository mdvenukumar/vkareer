<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VKareer - Your Career Marketplace</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #ffffff;
            color: #404145;
        }
        .header {
            background-color: #ffffff;
            box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
            padding: 20px 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }
        .nav-container {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }
        .logo {
            font-size: 28px;
            font-weight: 700;
            color: #404145;
            text-decoration: none;
        }
        .nav-buttons button {
            padding: 10px 20px;
            margin-left: 10px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .login-btn {
            background-color: transparent;
            color: #404145;
        }
        .login-btn:hover {
            background-color: #f5f5f5;
        }
        .jobs-btn {
            background-color: #1dbf73;
            color: #ffffff;
        }
        .jobs-btn:hover {
            background-color: #19a463;
        }
        .hero {
            background-image: url('https://fiverr-res.cloudinary.com/image/upload/q_auto,f_auto/v1/attachments/generic_asset/asset/bb5958e41c91bb37f4afe2a318b71599-1599344049983/bg-hero-1-1792-x1.png');
            background-size: cover;
            background-position: center;
            height: 680px;
            display: flex;
            align-items: center;
            margin-top: 80px;
        }
        .hero-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }
        .hero h1 {
            font-size: 48px;
            color: #ffffff;
            margin-bottom: 20px;
            max-width: 600px;
        }
        .hero p {
            font-size: 20px;
            color: #ffffff;
            margin-bottom: 30px;
            max-width: 500px;
        }
        .search-bar {
            display: flex;
            max-width: 500px;
        }
        .search-bar input {
            flex-grow: 1;
            padding: 15px;
            font-size: 16px;
            border: none;
            border-radius: 4px 0 0 4px;
        }
        .search-bar button {
            padding: 15px 30px;
            background-color: #1dbf73;
            color: #ffffff;
            border: none;
            border-radius: 0 4px 4px 0;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .search-bar button:hover {
            background-color: #19a463;
        }
    </style>
</head>
<body>
<header class="header">
    <nav class="nav-container">
        <a href="#" class="logo">VKareer</a>
        <div class="nav-buttons">
            <form action="adminLogin.jsp" method="post" style="display: inline;">
                <button type="submit" class="login-btn">Admin Login</button>
            </form>
            <form action="userjobs.jsp" method="post" style="display: inline;">
                <button type="submit" class="jobs-btn">Find Jobs</button>
            </form>
        </div>
    </nav>
</header>

<section class="hero">
    <div class="hero-content">
        <h1>Find the perfect job for your career</h1>
        <p>Millions of people use VKareer to turn their ideas into reality.</p>
        <form action="SearchServlet" method="GET" class="search-bar">
            <input type="text" name="query" placeholder="Try 'software developer'">
            <button type="submit">Search</button>
        </form>
    </div>
</section>
</body>
</html>