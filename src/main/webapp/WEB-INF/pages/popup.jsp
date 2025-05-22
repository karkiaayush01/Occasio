<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty popupMessage}">
    <style>
        .popup {
            padding: 16px;
            border-radius: 6px;
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            min-width: 250px;
            font-family: Arial, sans-serif;
            animation: fadeInOut 4s forwards;
        }

        .popup.success {
            background-color: #d4edda;
            color: #155724;
            border-left: 5px solid #28a745;
        }

        .popup.error {
            background-color: #f8d7da;
            color: #721c24;
            border-left: 5px solid #dc3545;
        }

        .popup.info {
            background-color: #cce5ff;
            color: #004085;
            border-left: 5px solid #007bff;
        }

        @keyframes fadeInOut {
            0% { opacity: 0; transform: translateY(-20px); }
            10% { opacity: 1; transform: translateY(0); }
            90% { opacity: 1; transform: translateY(0); }
            100% { opacity: 0; transform: translateY(-20px); display: none; }
        }
    </style>

    <div class="popup ${popupType}">
        <p>${popupMessage}</p>
    </div>
</c:if>
