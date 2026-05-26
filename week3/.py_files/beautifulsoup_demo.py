from bs4 import BeautifulSoup

# Sample HTML - imagine this came from response.text after a GET request
sample_html = """
<html>
  <head><title>Login Page</title></head>
  <body>
    <form action="/login" method="post">
      <input type="hidden" name="user_token" value="abc123secret456" />
      <input type="text"   name="username" placeholder="Username" />
      <input type="password" name="password" placeholder="Password" />
      <button type="submit">Login</button>
    </form>
    <div class="links">
      <a href="/register">Register</a>
      <a href="/forgot">Forgot password</a>
    </div>
  </body>
</html>
"""

# Parse the HTML
soup = BeautifulSoup(sample_html, 'html.parser')

# Finding elements
# 1. Find by tag name
title = soup.find('title')
print("Page title:", title.text)    # 'Login Page'

# 2. Find a specific input by its 'name' attribute
token_input = soup.find('input', {'name': 'user_token'})
csrf_token = token_input['value']   # Get the 'value' attribute
print("CSRF Token:", csrf_token)    # 'abc123secret456'

# 3. Find ALL links on the page
links = soup.find_all('a')
for link in links:
    print(f"Link: {link.text} -> {link.get('href')}")

# 4. Find ALL input fields in the form (useful for form fuzzing)
inputs = soup.find_all('input')
print("\nAll form inputs:")
for inp in inputs:
    print(f"  name={inp.get('name')} type={inp.get('type')} value={inp.get('value', '')}")

# 5. CSS selectors - powerful targeting
hidden_inputs = soup.select('input[type="hidden"]')
print("\nHidden inputs (potential CSRF tokens):")
for h in hidden_inputs:
    print(f"  {h['name']} = {h['value']}")
