<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>document</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* CSS du sidebar */
        :root {
            --navy-blue: #1A365D;
            --navy-light: #2D4A7C;
            --navy-dark: #0F1F3D;
            --cream: #F8F9FA;
            --cream-dark: #E9ECEF;
            --white: #FFFFFF;
            --gray: #6C757D;
            --gray-light: #DEE2E6;
            --gray-lighter: #F8F9FA;
            --accent: #2563EB;
            --success: #198754;
            --warning: #FFC107;
            --danger: #DC3545;
            --info: #0DCAF0;
            --border-radius: 8px;
            --box-shadow: 0 2px 10px rgba(26, 54, 93, 0.08);
            --transition: all 0.3s ease;
        }

        .admin-container {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 280px;
            background: var(--navy-blue);
            color: var(--white);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            transition: var(--transition);
            z-index: 1000;
        }

        .sidebar-header {
            padding: 2rem 1.5rem;
            border-bottom: 1px solid var(--navy-light);
        }

        .sidebar-header h1 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .sidebar-header p {
            font-size: 0.875rem;
            color: var(--gray-light);
            opacity: 0.8;
        }

        .nav-menu {
            padding: 1.5rem 0;
        }

        .nav-item {
            margin-bottom: 0.5rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.875rem 1.5rem;
            color: var(--white);
            text-decoration: none;
            transition: var(--transition);
            border-left: 3px solid transparent;
        }

        .nav-link:hover, .nav-link.active {
            background: var(--navy-light);
            border-left-color: var(--accent);
        }

        .nav-link i {
            margin-right: 0.75rem;
            width: 20px;
            text-align: center;
        }

        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
            background: var(--cream);
            min-height: 100vh;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--gray-light);
        }

        .page-title h2 {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--navy-blue);
            margin-bottom: 0.25rem;
        }

        .page-title p {
            color: var(--gray);
            font-size: 0.9rem;
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .back-btn {
            background: var(--navy-blue);
            color: var(--white);
            padding: 0.75rem 1.5rem;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.875rem;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .back-btn:hover {
            background: var(--navy-light);
        }

        /* CSS original du chat - NE PAS MODIFIER */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-color: #f0f2f5;
        }

        .chat-container {
            max-width: 1000px;
            margin: 20px auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
            height: 90vh;
        }

        .chat-header {
            padding: 20px;
            background: #2c3e50;
            color: white;
            border-radius: 10px 10px 0 0;
        }

        .chat-messages {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
        }

        .message {
            margin-bottom: 20px;
            display: flex;
            align-items: flex-start;
        }

        .message.user {
            flex-direction: row-reverse;
        }

        .message-content {
            max-width: 70%;
            padding: 12px 16px;
            border-radius: 15px;
            margin: 0 12px;
        }

        .user .message-content {
            background: #007bff;
            color: white;
            border-bottom-right-radius: 5px;
        }

        .ai .message-content {
            background: #e9ecef;
            color: #2c3e50;
            border-bottom-left-radius: 5px;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .user .avatar {
            background: #28a745;
            color: white;
        }

        .ai .avatar {
            background: #6c757d;
            color: white;
        }

        .chat-input {
            padding: 20px;
            border-top: 1px solid #dee2e6;
            background: white;
            border-radius: 0 0 10px 10px;
        }

        .input-group {
            display: flex;
            gap: 10px;
        }

        .input-group input {
            flex: 1;
            padding: 12px;
            border: 1px solid #dee2e6;
            border-radius: 20px;
            outline: none;
            font-size: 16px;
        }

        .input-group button {
            padding: 12px 24px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s;
        }

        .input-group button:hover {
            background: #0056b3;
        }

        .message-time {
            font-size: 12px;
            color: #6c757d;
            margin-top: 5px;
            text-align: right;
        }

        .typing-indicator {
            display: none;
            padding: 12px 16px;
            background: #e9ecef;
            border-radius: 15px;
            margin: 10px 0;
            color: #6c757d;
            animation: pulse 1.5s infinite;
        }

        @keyframes pulse {
            0% { opacity: .5; }
            50% { opacity: 1; }
            100% { opacity: .5; }
        }

        /* Scrollbar Styling */
        .chat-messages::-webkit-scrollbar {
            width: 6px;
        }

        .chat-messages::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        .chat-messages::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 3px;
        }

        .chat-messages::-webkit-scrollbar-thumb:hover {
            background: #555;
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .sidebar {
                width: 250px;
            }
            .main-content {
                margin-left: 250px;
            }
        }

        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }
            .sidebar.active {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <!-- Sidebar Navigation -->
        <jsp:include page="sidebarRh.jsp" />

        <!-- Contenu Principal -->
        <main class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="page-title">
                    <h2>RH AI Assistant</h2>
                    <p>Assistant intelligent pour vos questions RH</p>
                </div>
                <div class="user-menu">
                    <a href="${pageContext.request.contextPath}/accueilRh" class="back-btn">
                        <i class="fas fa-arrow-left"></i>
                        Retour au Dashboard
                    </a>
                </div>
            </div>

            <!-- Interface de Chat -->
            <div class="chat-container">
                <div class="chat-header">
                    <h2><i class="fas fa-robot"></i> RH AI Assistant</h2>
                </div>
                
                <div class="chat-messages" id="chatMessages">
                    <div class="message ai">
                        <div class="avatar">AI</div>
                        <div class="message-content">
                           Bonjour RH, je suis votre assistant IA. Comment puis-je vous aider aujourd'hui ?
                            <div class="message-time">Just now</div>
                        </div>
                    </div>
                    
                    <c:if test="${not empty answer}">
                        <div class="message user">
                            <div class="avatar">U</div>
                            <div class="message-content">
                                ${param.question}
                                <div class="message-time">Just now</div>
                            </div>
                        </div>
                        <div class="message ai">
                            <div class="avatar">AI</div>
                            <div class="message-content">
                                ${answer}
                                <div class="message-time">Just now</div>
                            </div>
                        </div>
                    </c:if>
                    
                    <div class="typing-indicator" id="typingIndicator">
                        ...
                    </div>
                </div>
                
                <div class="chat-input">
                    <form class="input-group" action="${pageContext.request.contextPath}/ask" method="post" id="questionForm">
                        <input type="text" name="question" placeholder="Type your question here..." required autocomplete="off">
                        <button type="submit">Demander</button>
                    </form>
                </div>
            </div>
        </main>
    </div>

    <script>
        document.getElementById('questionForm').addEventListener('submit', function(e) {
            const typingIndicator = document.getElementById('typingIndicator');
            const chatMessages = document.getElementById('chatMessages');
            
            // Show typing indicator
            typingIndicator.style.display = 'block';
            
            // Scroll to bottom
            chatMessages.scrollTop = chatMessages.scrollHeight;
        });

        // Scroll to bottom on page load
        window.onload = function() {
            const chatMessages = document.getElementById('chatMessages');
            chatMessages.scrollTop = chatMessages.scrollHeight;
        };
    </script>
</body>
</html>