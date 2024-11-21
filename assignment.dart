from abc import ABC, abstractmethod

class BankAccount:
    def __init__(self, account_number, owner_name, balance):
        self.__account_number = account_number  
        self.__owner_name = owner_name          
        self.__balance = balance                

    def get_balance(self):
        return f"Current balance for {self.__owner_name}: ${self.__balance}"

    def deposit(self, amount):
        if amount > 0:
            self.__balance += amount
            return f"${amount} deposited successfully. {self.get_balance()}"
        return "Invalid deposit amount."

    def withdraw(self, amount):
        if 0 < amount <= self.__balance:
            self.__balance -= amount
            return f"${amount} withdrawn successfully. {self.get_balance()}"
        return "Insufficient funds or invalid withdrawal amount."

class SavingsAccount(BankAccount):
    def __init__(self, account_number, owner_name, balance, interest_rate):
        super().__init__(account_number, owner_name, balance)
        self.__interest_rate = interest_rate  # Private variable for savings account

    def calculate_interest(self):
        return f"Yearly interest: ${self._BankAccount__balance * self.__interest_rate:.2f}"

class CurrentAccount(BankAccount):
    def withdraw(self, amount):
        overdraft_limit = 500  # Unique feature for CurrentAccount
        if 0 < amount <= (self._BankAccount__balance + overdraft_limit):
            self._BankAccount__balance -= amount
            return f"${amount} withdrawn successfully with overdraft. {self.get_balance()}"
        return "Overdraft limit exceeded or invalid withdrawal amount."

class Account(ABC):
    @abstractmethod
    def account_details(self):
        pass

class FixedDeposit(Account):
    def __init__(self, deposit_amount, duration_years, interest_rate):
        self.deposit_amount = deposit_amount
        self.duration_years = duration_years
        self.interest_rate = interest_rate

    def account_details(self):
        maturity_amount = self.deposit_amount * (1 + self.interest_rate) ** self.duration_years
        return f"Fixed Deposit: ${self.deposit_amount} for {self.duration_years} years at {self.interest_rate*100}% interest. Maturity amount: ${maturity_amount:.2f}"

if __name__ == "__main__":
    # Encapsulation
    my_account = BankAccount("123456", "Alice", 1000)
    print(my_account.deposit(500))
    print(my_account.withdraw(300))

    my_savings = SavingsAccount("789101", "Bob", 2000, 0.03)
    print(my_savings.get_balance())
    print(my_savings.calculate_interest())

    my_current = CurrentAccount("112233", "Charlie", 500)
    print(my_current.withdraw(900))  
    print(my_current.withdraw(200)) 

    my_fd = FixedDeposit(5000, 5, 0.05)
    print(my_fd.account_details())
