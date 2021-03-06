-- Keeps track of tokens generated by tokenizer attached
-- to the router.

local Token = {}
Token.__index = Token;

local db = assert( require("library.database").getDatabase() );

-- fetch token data from database
function Token.new(token)
    local cur = db:execute("SELECT * FROM tokens WHERE token = '" .. db:escape(token:upper()) .. "'");
    local res = cur:fetch({}, "a"); cur:close();
    cur:close();

    if not res then return nil; end;

    local self = setmetatable(res, Token);
    return self;
end

-- expire token immediatelly and make it unusable
function Token:expire()
    self.expires = os.time() - 1;
    db:execute("UPDATE tokens SET expires = " .. self.expires .. " WHERE token = '" .. db:escape(self.token) .. "'");
end

-- create new, fresh token in database
function Token.create(token)
    -- token is valid for 5 minutes since generated
    local expires = os.time() + 300;
    -- put token into database; this will return nil in
    -- case of duplicated token or 1 otherwise.
    local result = db:execute("INSERT INTO tokens (token, expires) VALUES('" .. db:escape(token:upper()) .. "', " .. expires .. ")");
    return result;
end

-- remove all expired tokens
function Token.clearExpired()
    -- delete tokens that are 24h after expiration.
    -- this allows us to display more apropriate error message
    -- when user provides expired token.
    local time = os.time() - 86400;
    return db:execute("DELETE FROM tokens WHERE expires <= " .. time);
end

return Token;

