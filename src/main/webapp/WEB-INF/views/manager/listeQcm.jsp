<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des QCM - AnnoncesManager</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --yale-blue: #0D3B66;
            --yale-blue-light: #1A5A9B;
            --yale-blue-dark: #082A4D;
            --lemon-chiffon: #FAF0CA;
            --lemon-chiffon-dark: #F5E6B3;
            --light-bg: #F8F9FA;
            --light-surface: #FFFFFF;
            --light-card: #FFFFFF;
            --text-primary: #2D3748;
            --text-secondary: #718096;
            --success: #38A169;
            --warning: #D69E2E;
            --danger: #E53E3E;
            --border-radius: 12px;
            --shadow: 0 8px 32px rgba(13, 59, 102, 0.1);
            --shadow-lg: 0 16px 48px rgba(13, 59, 102, 0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'SF Pro Display', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, var(--light-bg) 0%, #EDF2F7 100%);
            color: var(--text-primary);
            line-height: 1.6;
            min-height: 100vh;
        }

        .admin-layout {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Navigation */
        .sidebar {
            width: 280px;
            background: var(--yale-blue);
            padding: 0;
            border-right: 1px solid var(--yale-blue-dark);
            display: flex;
            flex-direction: column;
        }

        .sidebar-header {
            padding: 30px 25px;
            border-bottom: 1px solid rgba(250, 240, 202, 0.2);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--lemon-chiffon), var(--lemon-chiffon-dark));
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--yale-blue);
            font-size: 1.2rem;
            font-weight: bold;
        }

        .logo-text {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--lemon-chiffon);
        }

        .nav-section {
            padding: 25px;
        }

        .nav-title {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: rgba(250, 240, 202, 0.7);
            margin-bottom: 20px;
            font-weight: 600;
        }

        .nav-links {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 16px;
            color: rgba(250, 240, 202, 0.8);
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-weight: 500;
            position: relative;
        }

        .nav-link:hover {
            background: rgba(250, 240, 202, 0.1);
            color: var(--lemon-chiffon);
        }

        .nav-link.active {
            background: linear-gradient(135deg, var(--yale-blue-light), var(--yale-blue-dark));
            color: var(--lemon-chiffon);
            box-shadow: 0 4px 16px rgba(13, 59, 102, 0.3);
            border-left: 4px solid var(--lemon-chiffon);
        }

        .nav-link i {
            width: 20px;
            text-align: center;
            font-size: 1.1rem;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 0;
            background: var(--light-bg);
        }

        .top-header {
            background: var(--light-surface);
            padding: 20px 40px;
            border-bottom: 1px solid #E2E8F0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .page-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--yale-blue);
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--yale-blue), var(--lemon-chiffon-dark));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            border: 2px solid var(--yale-blue);
        }

        /* Content Area */
        .content-area {
            padding: 40px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .filter-section {
            background: var(--light-card);
            border-radius: var(--border-radius);
            padding: 25px 30px;
            margin-bottom: 30px;
            box-shadow: var(--shadow);
            border: 1px solid #E2E8F0;
        }

        .filter-label {
            display: block;
            margin-bottom: 12px;
            color: var(--yale-blue);
            font-weight: 600;
            font-size: 0.95rem;
            letter-spacing: 0.5px;
        }

        .filter-select {
            width: 100%;
            padding: 14px 18px;
            background: var(--light-bg);
            border: 2px solid #E2E8F0;
            border-radius: 8px;
            color: var(--text-primary);
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-family: inherit;
        }

        .filter-select:focus {
            outline: none;
            border-color: var(--yale-blue);
            box-shadow: 0 0 0 3px rgba(13, 59, 102, 0.1);
            background: white;
        }

        .empty-state {
            background: var(--light-card);
            border-radius: var(--border-radius);
            padding: 50px 30px;
            text-align: center;
            box-shadow: var(--shadow);
            border: 1px solid #E2E8F0;
            color: var(--text-secondary);
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 20px;
            color: #CBD5E0;
        }

        .departement-section {
            margin-bottom: 40px;
        }

        .departement-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--yale-blue);
            margin-bottom: 25px;
            padding-bottom: 12px;
            border-bottom: 2px solid var(--lemon-chiffon);
        }

        .question-card {
            background: var(--light-card);
            border-radius: var(--border-radius);
            padding: 30px;
            margin-bottom: 25px;
            box-shadow: var(--shadow);
            border: 1px solid #E2E8F0;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .question-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .question-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 20px;
            line-height: 1.4;
        }

        .question-actions {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .action-btn {
            padding: 10px 18px;
            border-radius: 6px;
            font-weight: 500;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s ease;
            font-size: 0.9rem;
        }

        .edit-btn {
            background: rgba(56, 161, 105, 0.1);
            color: var(--success);
            border: 1px solid rgba(56, 161, 105, 0.3);
        }

        .edit-btn:hover {
            background: var(--success);
            color: white;
        }

        .delete-btn {
            background: rgba(229, 62, 62, 0.1);
            color: var(--danger);
            border: 1px solid rgba(229, 62, 62, 0.3);
        }

        .delete-btn:hover {
            background: var(--danger);
            color: white;
        }

        .reponses-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .reponse-item {
            padding: 14px 18px;
            background: var(--light-bg);
            border-radius: 8px;
            border-left: 4px solid #CBD5E0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .reponse-correct {
            border-left-color: var(--success);
            background: rgba(56, 161, 105, 0.05);
        }

        .correct-indicator {
            color: var(--success);
            font-weight: bold;
            font-size: 1.2rem;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .sidebar {
                width: 240px;
            }
            .content-area {
                padding: 30px;
            }
        }

        @media (max-width: 768px) {
            .admin-layout {
                flex-direction: column;
            }
            .sidebar {
                width: 100%;
                height: auto;
            }
            .content-area {
                padding: 20px;
            }
            .top-header {
                padding: 20px;
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            .question-actions {
                flex-direction: column;
            }
            .action-btn {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="admin-layout">
        <!-- Sidebar Navigation -->
        <jsp:include page="sidebarManager.jsp" />

        <!-- Main Content -->
        <div class="main-content">
            <div class="top-header">
                <h1 class="page-title">Gestion des QCM</h1>
                <div class="user-menu">
                    <div class="user-avatar">AD</div>
                </div>
            </div>

            <div class="content-area">
                <div class="filter-section">
                    <label for="departementFilter" class="filter-label">Filtrer par département</label>
                    <select id="departementFilter" class="filter-select">
                        <option value="all">Tous les départements</option>
                        <c:forEach var="departement" items="${departements}">
                            <option value="${departement.id}">${departement.libelleDepartement}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <c:if test="${empty questionsReponses}">
                    <div class="empty-state">
                        <i class="fas fa-clipboard-list"></i>
                        <h3>Aucun QCM disponible</h3>
                        <p>Créez votre premier QCM pour commencer à évaluer les candidats</p>
                    </div>
                </c:if>

                <div id="qcmContainer">
                    <c:forEach var="departement" items="${departements}">
                        <c:set var="hasQuestions" value="false" />
                        <c:forEach var="qr" items="${questionsReponses}">
                            <c:if test="${qr.idDepartement == departement.id}">
                                <c:set var="hasQuestions" value="true" />
                            </c:if>
                        </c:forEach>
                        
                        <c:if test="${hasQuestions}">
                            <div class="departement-section" data-departement="${departement.id}">
                                <h2 class="departement-title">${departement.libelleDepartement}</h2>
                                
                                <c:forEach var="qr" items="${questionsReponses}">
                                    <c:if test="${qr.idDepartement == departement.id}">
                                        <c:set var="questionDejaAffichee" value="false" />
                                        <c:forEach var="dejaVu" items="${questionsReponses}">
                                            <c:if test="${dejaVu.questionId == qr.questionId && questionsReponses.indexOf(dejaVu) < questionsReponses.indexOf(qr)}">
                                                <c:set var="questionDejaAffichee" value="true" />
                                            </c:if>
                                        </c:forEach>
                                        
                                        <c:if test="${not questionDejaAffichee}">
                                            <div class="question-card">
                                                <h3 class="question-title">${qr.question}</h3>
                                                <div class="question-actions">
                                                    <a href="${pageContext.request.contextPath}/manager/modifierQcm?id_question=${qr.questionId}" class="action-btn edit-btn">
                                                        <i class="fas fa-edit"></i> Modifier
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/manager/supprimerQcm?id_question=${qr.questionId}" class="action-btn delete-btn">
                                                        <i class="fas fa-trash-alt"></i> Supprimer
                                                    </a>
                                                </div>
                                                <div class="reponses-list">
                                                    <c:forEach var="reponse" items="${questionsReponses}">
                                                        <c:if test="${reponse.questionId == qr.questionId}">
                                                            <div class="reponse-item ${reponse.estVraie ? 'reponse-correct' : ''}">
                                                                ${reponse.reponse}
                                                                <c:if test="${reponse.estVraie}">
                                                                    <span class="correct-indicator">✓</span>
                                                                </c:if>
                                                            </div>
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const filter = document.getElementById('departementFilter');
            const sections = document.querySelectorAll('.departement-section');
            
            filter.addEventListener('change', function() {
                const selectedValue = this.value;
                
                sections.forEach(section => {
                    const departementId = section.getAttribute('data-departement');
                    if (selectedValue === 'all' || departementId === selectedValue) {
                        section.style.display = 'block';
                    } else {
                        section.style.display = 'none';
                    }
                });
            });
        });
    </script>
</body>
</html>