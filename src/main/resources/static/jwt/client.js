/**
 * @author SONG
 */

$(window).on('load', () => {
  // VARIABLES =============================================================
  var TOKEN_KEY = "jwtToken"
  var $notLoggedIn = $("#notLoggedIn");
  var $loggedIn = $("#loggedIn").hide();
  var $loggedInBody = $("#loggedInBody");
  var $response = $("#response");
  var $login = $("#login");
  var $userInfo = $("#userInfo").hide();

  // FUNCTIONS =============================================================
  function getJwtToken() {
    return sessionStorage.getItem(TOKEN_KEY);
  }

  function setJwtToken(token) {
	  sessionStorage.setItem(TOKEN_KEY, token);
  }

  function removeJwtToken() {
	  sessionStorage.removeItem(TOKEN_KEY);
  }

  function doLogin(loginData) {
    $.ajax({
      url: "http://127.0.0.1:8086/api/auth",
      type: "POST",
      data: JSON.stringify(loginData),
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: function (data, textStatus, jqXHR) {
        console.log(data)
        setJwtToken(data.token); // 客户端: 浏览器 - app
        $login.hide();
        $notLoggedIn.hide();
        showTokenInformation();
        showUserInformation();
      },
      error: function (jqXHR, textStatus, errorThrown) {
        if (jqXHR.status === 401) {
          $('#loginErrorModal')
              .modal("show")
              .find(".modal-body")
              .empty()
              .html("<p>Spring exception:<br>" + jqXHR.responseJSON.exception + "</p>");
        } else {
          throw new Error("an unexpected error occured: " + errorThrown);
        }
      }
    });
  }

  function doLogout() {
    removeJwtToken();
    $login.show();
    $userInfo
        .hide()
        .find("#userInfoBody").empty();
    $loggedIn.hide();
    $loggedInBody.empty();
    $notLoggedIn.show();
  }

  function createAuthorizationTokenHeader() {
    var token = getJwtToken();
    if (token) {
      return {"Authorization": "Bearer " + token};
    } else {
      return {};
    }
  }

  function showUserInformation() {
    $.ajax({
      url: "http://127.0.0.1:8086/api/user",
      type: "GET",
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      headers: createAuthorizationTokenHeader(),
      success: function (data, textStatus, jqXHR) {
        var $userInfoBody = $userInfo.find("#userInfoBody");

        $userInfoBody.append($("<div>").text("Username: " + data.username));
        $userInfoBody.append($("<div>").text("Email: " + data.email));

        var $authorityList = $("<ul>");
        data.authorities.forEach(function (authorityItem) {
          $authorityList.append($("<li>").text(authorityItem.authority));
        });
        var $authorities = $("<div>").text("Authorities:");
        $authorities.append($authorityList);

        $userInfoBody.append($authorities);
        $userInfo.show();
      }
    });
  }

  function showTokenInformation() {
    var jwtToken = getJwtToken();
    var decodedToken = jwt_decode(jwtToken);

    $loggedInBody.append($("<h4>").text("Token"));
    $loggedInBody.append($("<div>").text(jwtToken).css("word-break", "break-all"));
    $loggedInBody.append($("<h4>").text("Token claims"));

    var $table = $("<table>")
        .addClass("table table-striped");
    appendKeyValue($table, "sub", decodedToken.sub);
    appendKeyValue($table, "iat", decodedToken.iat);
    appendKeyValue($table, "exp", decodedToken.exp);

    $loggedInBody.append($table);

    $loggedIn.show();
  }

  function appendKeyValue($table, key, value) {
    var $row = $("<tr>")
        .append($("<td>").text(key))
        .append($("<td>").text(value));
    $table.append($row);
  }

  function showResponse(statusCode, message) {
    $response
        .empty()
        .text("status code: " + statusCode + "\n-------------------------\n" + message);
  }

  // REGISTER EVENT LISTENERS =============================================================
  $("#loginForm").submit(function (event) {
    event.preventDefault();

    var $form = $(this);
    var formData = {
      username: $form.find('input[name="username"]').val(),
      password: $form.find('input[name="password"]').val()
    };

    doLogin(formData);
  });

  $("#logoutButton").click(doLogout);

  $("#exampleServiceBtn").click(function () {
    $.ajax({
      url: "http://127.0.0.1:8086/api/protectedclerk",
      type: "GET",
      contentType: "application/json; charset=utf-8",
      headers: createAuthorizationTokenHeader(),
      success: function (data, textStatus, jqXHR) {
        showResponse(jqXHR.status, data);
      },
      error: function (jqXHR, textStatus, errorThrown) {
        showResponse(jqXHR.status, errorThrown);
      }
    });
  });

  $("#adminServiceBtn").click(function () {
    $.ajax({
      url: "http://127.0.0.1:8086/api/protectedadmin",
      type: "GET",
      contentType: "application/json; charset=utf-8",
      headers: createAuthorizationTokenHeader(),
      success: function (data, textStatus, jqXHR) {
        showResponse(jqXHR.status, data);
      },
      error: function (jqXHR, textStatus, errorThrown) {
        showResponse(jqXHR.status, errorThrown);
      }
    });
  });

  $loggedIn.click(function () {
    $loggedIn
        .toggleClass("text-hidden")
        .toggleClass("text-shown");
  });

  // INITIAL CALLS =============================================================
  if (getJwtToken()) {
    $login.hide();
    $notLoggedIn.hide();
    showTokenInformation();
    showUserInformation();
  }
});